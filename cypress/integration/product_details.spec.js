describe('jungle', () => {
  beforeEach(() => {
    cy.visit('localhost:3000/')
  })

  it("can navigate from home to a product detail page", () => {
    cy.get("article:first").click()
    cy.get("section").should("contain", "in stock at")
  });
})