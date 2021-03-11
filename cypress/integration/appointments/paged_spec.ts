describe('The paged view of the appointments feature', () => {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/appointments/paged_spec.ts')
    cy.login()
    cy.visit('/event_calendar/list/2020-01-01?format=paged')
  })

  it('should have a valid ui', function () {
    cy.document().toMatchImageSnapshot({
      name: `appointments_paged.${Cypress.env('viewtype')}`,
      blackout: [
        '.elgg-module-aside:last'
      ]
    })
  })

  // noinspection DuplicatedCode
  it('should have pages of appointments', function () {
    cy.get('.elgg-pagination:first li').should('have.length.of.at.least', this.counts.appointments.paged.minPages)
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

  it('should add appointments to the personal calendar', function () {
    cy.get('[data-menu-item=mine]').click()
    cy.contains(this.identifiers.appointments.paged.noPersonalAppointments)
    cy.get('[data-menu-item=all]').click()
    cy.get('.event_calendar_paged_title:first a').invoke('text')
      .then(
        firstAppointmentTitle => {
          cy.get('.event_calendar_paged_calendar:first input').check()
          cy.contains(this.identifiers.appointments.paged.appointmentAddedToPersonalCalendar)
          cy.get('[data-menu-item=mine]').click()
          cy.contains(this.identifiers.appointments.paged.noPersonalAppointments).should('not.exist')
          cy.get('.event_calendar_paged_title:first a').should('contain', firstAppointmentTitle)
          cy.get('.event_calendar_paged_calendar:first input').uncheck()
          cy.contains(this.identifiers.appointments.paged.appointmentRemovedFromPersonalCalendar)
          cy.get('[data-menu-item=mine]').click()
          cy.contains(this.identifiers.appointments.paged.noPersonalAppointments)
        }
      )
  })
})
