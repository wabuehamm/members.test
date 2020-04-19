const cypress = require('cypress')
const fse = require('fs-extra')
const path = require('path')
const { merge } = require('mochawesome-merge')
const generator = require('mochawesome-report-generator')

async function runTests() {
    await fse.remove('mochawesome-report')
    const { totalFailed } = await cypress.run()
    const jsonReport = await merge()
    await generator.create(jsonReport)
    await fse.remove(path.join('mochawesome-report', 'mochawesome*.json'))
    process.exit(totalFailed)
}

runTests()
