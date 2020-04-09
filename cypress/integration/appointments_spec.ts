describe('The appointments feature', () => {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/appointments_spec.ts')
    cy.login()
    cy.visit('/event_calendar/list/')
  })

  it('is reachable', function () {
    cy.contains(this.identifiers.appointments.title)

    cy.document().toMatchImageSnapshot({
      name: 'appointments',
      blackout: [
        '.elgg-pagination',
        '.event_calendar_paged',
        '.elgg-module-aside'
      ]
    })
  })

  it('should have appointments', function () {
    cy.get('.event_calendar_paged_title').should('have.length.of.at.least', this.counts.appointments.minEntries)
  })

  it('should have a working ical export')
  it('should have a working ical import')
})
