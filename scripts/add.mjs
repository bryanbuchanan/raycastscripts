#!/opt/homebrew/bin/node
// #!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Add Numbers Together
// @raycast.mode silent

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
	
	let text = stdout
	const regex = /:\s*\$?([\d,]+(?:\.\d+)?)(?=\s*$)/gm
	const matches = text.match(regex)
	
	if (matches) {
	
		const floats = matches.map(match => parseFloat(match.replace(/[^\d.]/g, '')))
		const total = floats.reduce((sum, num) => sum + num, 0)
		
		const childProcess = exec('pbcopy', () => {
			return console.log(total)
		})
		
		childProcess.stdin.write(`${total}`)
		childProcess.stdin.end()
		
	} else {
		console.log('No numbers found.')
	}
	
})
