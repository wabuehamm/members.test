describe('The agenda view of the appointments feature', () => {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/appointments/agenda_spec.ts')
    cy.login()
    cy.visit('/event_calendar/list/2020-01-01?format=paged')
  })

  it('should have a valid ui', function () {
    cy.document().toMatchImageSnapshot({
      name: 'appointments_agenda',
      blackout: [
        '.elgg-module-aside:last'
      ]
    })
  })

  it('should have pages of appointments', function () {
    cy.get('.elgg-pagination:first li').should('have.length.of.at.least', this.counts.appointments.agenda.minPages)
  })

  it('should have a working pagination', function () {
    cy.get('.event_calendar_paged_title:first a').invoke('text')
      .then(
        firstAppointmentTitle => {
          cy.get('.elgg-pagination:first li:last').click()

          cy.get('.event_calendar_paged_title:first a').should('not.contain', firstAppointmentTitle)
        }
      )

  })
})
