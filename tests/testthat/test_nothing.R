describe("Get version of the module", {
  it("The version is 0.0.1", {
    expected_version <- c("0.0.1")
    obtained_version <- packageVersion("mip")
    version_are_equal <- expected_version == obtained_version
    expect_true(version_are_equal)
  })
})
