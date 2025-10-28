#!/usr/bin/env node

// @raycast.schemaVersion 1
// @raycast.title Create Image Diptych
// @raycast.mode fullOutput

const { execSync } = require('child_process');
const path = require('path');
const sharp = require('sharp');

// Get multiple files using AppleScript
const appleScript = `
set selectedFiles to choose file with prompt "Select images to combine" with multiple selections allowed
set fileList to {}
repeat with aFile in selectedFiles
	set end of fileList to POSIX path of aFile
end repeat
set AppleScript's text item delimiters to linefeed
return fileList as text
`;

async function combineImages(filePaths) {
	console.log(`Combining ${filePaths.length} image(s)...\n`);

	// Load all images and get their metadata
	const images = await Promise.all(
		filePaths.map(async (filePath) => ({
			path: filePath,
			image: sharp(filePath),
			metadata: await sharp(filePath).metadata()
		}))
	);

	// Calculate dimensions for vertical stack layout
	const minWidth = Math.min(...images.map(img => img.metadata.width));

	// Resize images to same width and combine
	const resizedBuffers = await Promise.all(
		images.map(img =>
			img.image
				.resize({ width: minWidth, fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 1 } })
				.toBuffer()
		)
	);

	// Create composite image with correct total height
	const resizedMetadata = await Promise.all(
		resizedBuffers.map(buffer => sharp(buffer).metadata())
	);
	const totalHeight = resizedMetadata.reduce((sum, meta) => sum + meta.height, 0);

	let yOffset = 0;
	const compositeImages = resizedBuffers.map((buffer, i) => {
		const position = { left: 0, top: yOffset };
		yOffset += resizedMetadata[i].height;
		return { input: buffer, ...position };
	});

	// Create output filename in same directory as first image
	const outputDir = path.dirname(filePaths[0]);
	const outputPath = path.join(outputDir, 'combined.png');

	// Combine and save
	await sharp({
		create: {
			width: minWidth,
			height: totalHeight,
			channels: 3,
			background: { r: 255, g: 255, b: 255 }
		}
	})
	.composite(compositeImages)
	.png({ compressionLevel: 9 })
	.toFile(outputPath);

	console.log(`✓ Combined image saved to:`);
	console.log(outputPath);
}

try {
	const result = execSync(`osascript -e '${appleScript.replace(/'/g, "'\\''")}'`, {
		encoding: 'utf8'
	});

	if (!result.trim()) {
		console.log('No files selected');
		process.exit(1);
	}

	const filePaths = result.trim().split('\n');
	combineImages(filePaths).catch(error => {
		console.error('Error:', error.message);
		process.exit(1);
	});

} catch (error) {
	console.error('Error:', error.message);
	process.exit(1);
}