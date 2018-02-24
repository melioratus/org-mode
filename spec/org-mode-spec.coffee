describe "org-mode package grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("org-mode")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.org-mode")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.org-mode"

  it "tokenizes spaces", ->
    {tokens} = grammar.tokenizeLine(" ")
    expect(tokens[0]).toEqual value: " ", scopes: ["source.org-mode"]

  it "tokenizes single line comments", ->
    {tokens} = grammar.tokenizeLine(" # this is a comment")
    expect(tokens[0]).toEqual value: " # ", scopes: ["source.org-mode", "comment.line.org-mode","punctuation.definition.comment.org-mode"]
    expect(tokens[1]).toEqual value: "this is a comment", scopes: ["source.org-mode", "comment.line.org-mode"]

  it "tokenizes multi line comments", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens] = grammar.tokenizeLines """
    #+BEGIN_COMMENT
    This is a
    multi line comment.
    #+END_COMMENT
    """
    expect(firstLineTokens[0]).toEqual value: "#+BEGIN_COMMENT", scopes: ["source.org-mode", "comment.block.org-mode", "punctuation.definition.comment.org-mode"]
    expect(secondLineTokens[0]).toEqual value: "This is a", scopes: ["source.org-mode", "comment.block.org-mode"]
    expect(thirdLineTokens[0]).toEqual value: "multi line comment.", scopes: ["source.org-mode", "comment.block.org-mode"]
    expect(forthLineTokens[0]).toEqual value: "#+END_COMMENT", scopes: ["source.org-mode", "comment.block.org-mode", "punctuation.definition.comment.org-mode"]

  it "tokenizes single line literal examples", ->
    {tokens} = grammar.tokenizeLine(" : This is a literal example on single line.")
    expect(tokens[0]).toEqual value: " : ", scopes: ["source.org-mode", "string.unquoted.org-mode", "punctuation.definition.string.org-mode"]
    expect(tokens[1]).toEqual value: "This is a literal example on single line.", scopes: ["source.org-mode", "string.unquoted.org-mode"]

  it "tokenizes multi line literal examples", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens] = grammar.tokenizeLines """
    #+BEGIN_EXAMPLE
    This is a
    multiple line literal example.
    #+END_EXAMPLE
    """
    expect(firstLineTokens[0]).toEqual value: "#+BEGIN_EXAMPLE", scopes: ["source.org-mode", "punctuation.definition.string.org-mode"]
    expect(secondLineTokens[0]).toEqual value: "This is a", scopes: ["source.org-mode", "string.unquoted.org-mode"]
    expect(thirdLineTokens[0]).toEqual value: "multiple line literal example.", scopes: ["source.org-mode", "string.unquoted.org-mode"]
    expect(forthLineTokens[0]).toEqual value: "#+END_EXAMPLE", scopes: ["source.org-mode", "punctuation.definition.string.org-mode"]

  it "tokenizes multi line quote blocks", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens] = grammar.tokenizeLines """
    #+BEGIN_QUOTE
    This is a
    multiple line quote.
    #+END_QUOTE
    """
    expect(firstLineTokens[0]).toEqual value: "#+BEGIN_QUOTE", scopes: ["source.org-mode", "punctuation.definition.quote.org-mode"]
    expect(secondLineTokens[0]).toEqual value: "This is a", scopes: ["source.org-mode", "markup.quote.org-mode"]
    expect(thirdLineTokens[0]).toEqual value: "multiple line quote.", scopes: ["source.org-mode", "markup.quote.org-mode"]
    expect(forthLineTokens[0]).toEqual value: "#+END_QUOTE", scopes: ["source.org-mode", "punctuation.definition.quote.org-mode"]


  it "tokenizes shell code blocks", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens, fifthLineTokens, sixthLineTokens] = grammar.tokenizeLines """
    #+NAME: shell-code
    #+BEGIN_SRC shell :eval never :noweb yes
    VARIABLE_NAME=`hostname`
    echo ${VARIABLE_NAME}
    #+END_SRC
    # Comment below shell-code
    """
    # Disabled # expect(firstLineTokens[0]).toEqual value: "#+NAME: shell-code", scopes: ["source.org-mode"]
    expect(secondLineTokens[0]).toEqual value: "#+BEGIN_SRC ", scopes: ["source.org-mode", "punctuation.definition.string.org-mode"]
    expect(secondLineTokens[1]).toEqual value: "shell", scopes: ["source.org-mode", "code-block.type.org-mode"]
    expect(secondLineTokens[2]).toEqual value: " :eval never :noweb yes", scopes: ["source.org-mode", "code-block.code-block-headers.org-mode"]
    # Disabled # expect(secondLineTokens[3]).toEqual value: "This is a", scopes: ["source.org-mode", "bc4"]
    # Disabled # expect(secondLineTokens[4]).toEqual value: "This is a", scopes: ["source.org-mode", "bc5"]
    expect(thirdLineTokens[0]).toEqual value: "VARIABLE_NAME=", scopes: ["source.org-mode", "source.embedded.shell-org-mode"]
    expect(thirdLineTokens[1]).toEqual value: "`", scopes: ["source.org-mode", "source.embedded.shell-org-mode", "string.interpolated.backtick.shell-org-mode", "punctuation.definition.string.begin.shell-org-mode"]
    expect(thirdLineTokens[2]).toEqual value: "hostname", scopes: ["source.org-mode", "source.embedded.shell-org-mode", "string.interpolated.backtick.shell-org-mode"]
    expect(thirdLineTokens[3]).toEqual value: "`", scopes: ["source.org-mode", "source.embedded.shell-org-mode", "string.interpolated.backtick.shell-org-mode", "punctuation.definition.string.end.shell-org-mode"]
    expect(forthLineTokens[0]).toEqual value: "echo", scopes: ["source.org-mode", "source.embedded.shell-org-mode", "support.function.builtin.shell-org-mode"]
    expect(forthLineTokens[1]).toEqual value: " ", scopes: ["source.org-mode", "source.embedded.shell-org-mode"]
    expect(forthLineTokens[2]).toEqual value: "${", scopes: ["source.org-mode", "source.embedded.shell-org-mode", "variable.other.bracket.shell-org-mode", "punctuation.definition.variable.shell-org-mode"]
    expect(forthLineTokens[3]).toEqual value: "VARIABLE_NAME", scopes: ["source.org-mode", "source.embedded.shell-org-mode", "variable.other.bracket.shell-org-mode"]
    expect(forthLineTokens[4]).toEqual value: "}", scopes: ["source.org-mode", "source.embedded.shell-org-mode", "variable.other.bracket.shell-org-mode", "punctuation.definition.variable.shell-org-mode"]
    expect(fifthLineTokens[0]).toEqual value: "#+END_SRC", scopes: ["source.org-mode", "punctuation.definition.string.org-mode"]
    expect(sixthLineTokens[0]).toEqual value: "# ", scopes: ["source.org-mode", "comment.line.org-mode", "punctuation.definition.comment.org-mode"]
    expect(sixthLineTokens[1]).toEqual value: "Comment below shell-code", scopes: ["source.org-mode", "comment.line.org-mode"]



  it "tokenizes heading 9", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens] = grammar.tokenizeLines """
    ********* Heading 9
    Body of Heading - Line 1
    * Another Heading
    """
    expect(firstLineTokens[0]).toEqual value: "********", scopes: ["source.org-mode", "markup.heading.heading-9.org-mode", "leading-star.org-mode"]
    expect(firstLineTokens[1]).toEqual value: "*", scopes: ["source.org-mode", "markup.heading.heading-9.org-mode", "markup.heading.marker.org-mode"]
    expect(firstLineTokens[2]).toEqual value: " ", scopes: ["source.org-mode", "markup.heading.heading-9.org-mode", "markup.heading.space.org-mode"]
    expect(firstLineTokens[3]).toEqual value: "Heading 9", scopes: ["source.org-mode", "markup.heading.heading-9.org-mode"]
    expect(secondLineTokens[0]).toEqual value: "Body of Heading - Line 1", scopes: ["source.org-mode"]
    expect(thirdLineTokens[0]).toEqual value: "*", scopes: ["source.org-mode", "markup.heading.heading-1.org-mode", "markup.heading.marker.org-mode"]

#
#   it "tokenizes heading 8", ->
#     [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens, fifthLineTokens] = grammar.tokenizeLines """
#     ******** Heading 8
#     Body of Heading - Line 1
#     ********* Heading 9
#     Body of Heading - Line 1
#     * Another Heading
#     """
#     expect(firstLineTokens[0]).toEqual value: "********", scopes: ["source.org-mode", "markup.heading.heading-8.org-mode", "punctuation.definition.markup.heading.heading-8.begin.org-mode"]
#     expect(firstLineTokens[1]).toEqual value: " ", scopes: ["source.org-mode", "markup.heading.heading-8.org-mode", "punctuation.definition.markup.heading.spaces.org-mode"]
#     expect(firstLineTokens[2]).toEqual value: "Heading 8", scopes: ["source.org-mode", "markup.heading.heading-8.org-mode", "markup.heading.org-mode"]
#     expect(secondLineTokens[0]).toEqual value: "Body of Heading - Line 1", scopes: ["source.org-mode", "markup.heading.heading-8.org-mode", 'meta.section.block']
#     expect(thirdLineTokens[0]).toEqual value: "#+END_QUOTE", scopes: ["source.org-mode", "text.plain.embedded.org-mode", "punctuation.definition.string.org-mode"]
#     expect(forthLineTokens[0]).toEqual value: "* ", scopes: ["source.org-mode", "markup.heading.heading-8.org-mode", "punctuation.definition.markup.heading.heading-8.end.org-mode"]
