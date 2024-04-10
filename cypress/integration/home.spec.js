

describe('jungle', () => {
  beforeEach(() => {
    cy.visit('localhost:3000/')
  })

  it("Has 2 products on the home page", () => {
    cy.get(".products article").should("have.length", 2);
  });
})