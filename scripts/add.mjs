#!/opt/homebrew/bin/node
// #!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Add Numbers Together
// @raycast.mode silent

// silent, fullOutput

// Optional parameters:
// @raycast.icon ➕

/**
 * Searches clipboard content for numbers following colons in any given line, 
 * adds them up, and replaces the clipboard with the sum. Useful for quickly
 * adding up line items in things like text documents, without using
 * a spreadsheet.
 */

import { exec } from 'child_process'

exec('pbpaste', (err, stdout) => {
	
	// Get clipboard content
	let text = stdout
	
	// Create empty number array
	const numbers = []
	let total = 0
	
	// Split into individual lines
	const lines = text.split('\n')
	
	// Loop through each line
	lines.forEach(line => {
		
		// Get matches
		const regex = /(?<=[:|]\s*)-?\d{1,3}(,\d{3})*(\.\d{2})?/
		const match = line.match(regex)
		
		if (match) {
			// Convert to float
			let float = parseFloat(match[0].replace(/,/g, ''))
			// Add match to numbers
			numbers.push(float)
		}
		
	})
	
	// Add up
	numbers.forEach(number => {
		total += number
	})
	
	// Round
	total = total.toFixed(2)

	// Copy to clipboard and display	
	const childProcess = exec('pbcopy', () => {
		return console.log(total)
	})
	childProcess.stdin.write(`${total}`)
	childProcess.stdin.end()
	
})
