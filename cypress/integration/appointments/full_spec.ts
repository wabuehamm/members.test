describe('The agenda view of the appointments feature', () => {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/appointments/full_spec.ts')
    cy.login()
    cy.visit('/event_calendar/list/2020-01-01?format=full')
  })

  it('should have a valid ui', function () {
    cy.document().toMatchImageSnapshot({
      name: 'appointments_full',
      blackout: [
        '.elgg-module-aside:last'
      ]
    })
  })
})
