require "rails_helper"

RSpec.describe CommentComponent, type: :component do
  it "displays a comment" do
    customer = create(:customer, :avatared, username: "george")
    feedback = create(:feedback, user: customer)
    comment = create(:comment, user: customer, commentable: feedback, content: "LOL")

    render_inline(CommentComponent.with_collection([comment]))

    expect(rendered_component).to have_text "@george"
    expect(rendered_component).to have_text "LOL"
    expect(rendered_component).to have_text "Reply"
    expect(rendered_component).to have_selector "form.hidden", text: "Add Comment"
    expect(rendered_component).to have_selector "#comment-#{comment.id}"
  end

  describe "linking to self" do
    it "links orphaned comments with child" do
      customer = create(:customer, :avatared, username: "george")
      feedback = create(:feedback, user: customer)
      orphan_comment = create(:comment, content: "OMG", user: customer, commentable: feedback)
      child_comment = create(:comment, content: "LOL", parent: orphan_comment, user: customer, commentable: feedback)

      render_inline(CommentComponent.with_collection([orphan_comment]))

      expect(rendered_component).to have_link nil, href: "#comment-#{orphan_comment.id}"
    end

    it "does not link orphaned comments without children" do
      customer = create(:customer, :avatared)
      feedback = create(:feedback, user: customer)
      orphan_comment = create(:comment, parent: nil, user: customer, commentable: feedback)

      render_inline(CommentComponent.with_collection([orphan_comment]))

      expect(rendered_component).not_to have_link nil, href: "#comment-#{orphan_comment.id}"
    end

    it "does not link parented comments" do
      customer = create(:customer, :avatared)
      feedback = create(:feedback, user: customer)
      parent_comment = create(:comment, parent: nil, user: customer, commentable: feedback)
      comment = create(:comment, parent: parent_comment, user: customer, commentable: feedback)

      render_inline(CommentComponent.with_collection([comment]))

      expect(rendered_component).not_to have_link nil, href: "#comment-#{comment.id}"
    end
  end

  describe "body indentation under comment head" do
    it "indents orphaned comment's body" do
      customer = create(:customer, :avatared, username: "george")
      feedback = create(:feedback, user: customer)
      comment = create(:comment, user: customer, commentable: feedback, content: "LOL")

      render_inline(CommentComponent.with_collection([comment]))

      expect(rendered_component).to have_selector "p.ml-12", text: "LOL"
    end

    it "none-indented parented comment's body" do
      customer = create(:customer, :avatared, username: "george")
      feedback = create(:feedback, user: customer)
      parent_comment = create(:comment, user: customer, commentable: feedback, content: "OMG")
      comment = create(:comment, parent: parent_comment, user: customer, commentable: feedback, content: "LOL")

      render_inline(CommentComponent.with_collection([comment]))

      expect(rendered_component).to have_selector "p.test-no-indentation", text: "LOL"
    end
  end

  it "only indents the first reply" do
    customer = create(:customer, :avatared, username: "george")
    child_customer = create(:customer, :avatared, username: "bob")
    feedback = create(:feedback, user: customer)
    parent_comment = create(:comment,
                            content: "OMG",
                            user: customer,
                            commentable: feedback)
    child_comment = create(:comment,
                           content: "LOL",
                           parent: parent_comment,
                           user: child_customer,
                           commentable: feedback)
    grandchild_comment = create(:comment,
                                content: "TTYL",
                                parent: child_comment,
                                user: customer,
                                commentable: feedback)

    render_inline(CommentComponent.with_collection([parent_comment]))

    expect(rendered_component).to have_selector "p.ml-12.test-nesting-level-0", text: "OMG"
    expect(rendered_component).to have_selector "p.test-no-indentation.test-nesting-level-1", text: "@george LOL"
    expect(rendered_component).to have_selector "p.test-no-indentation.test-nesting-level-2", text: "@bob TTYL"
  end

  it "only indents the first new comment" do
    customer = create(:customer, :avatared, username: "george")
    child_customer = create(:customer, :avatared, username: "bob")
    feedback = create(:feedback, user: customer)
    parent_comment = create(:comment,
                            content: "OMG",
                            user: customer,
                            commentable: feedback)
    child_comment = create(:comment,
                           content: "LOL",
                           parent: parent_comment,
                           user: child_customer,
                           commentable: feedback)
    grandchild_comment = create(:comment,
                                content: "TTYL",
                                parent: child_comment,
                                user: customer,
                                commentable: feedback)

    render_inline(CommentComponent.with_collection([parent_comment]))

    expect(rendered_component).to have_selector "div.ml-12.test-new-comment-indentation.test-nesting-level-0"
    expect(rendered_component).to have_selector "div.test-no-new-comment-indentation.test-nesting-level-1"
    expect(rendered_component).to have_selector "div.test-no-new-comment-indentation.test-nesting-level-2"
  end

  describe "@mentions" do
    it "does not @mention orphaned comments" do
      customer = create(:customer, :avatared, username: "george")
      feedback = create(:feedback, user: customer)
      comment = create(:comment, user: customer, commentable: feedback, content: "LOL")

      render_inline(CommentComponent.with_collection([comment]))

      expect(rendered_component).to have_selector "p.test-nesting-level-0", text: "LOL"
    end

    it "@mentions comments with parent @username" do
      customer = create(:customer, :avatared, username: "george")
      child_customer = create(:customer, :avatared, username: "bob")
      feedback = create(:feedback, user: customer)
      parent_comment = create(:comment,
                              content: "OMG",
                              user: customer,
                              commentable: feedback)
      child_comment = create(:comment,
                             content: "LOL",
                             parent: parent_comment,
                             user: child_customer,
                             commentable: feedback)
      grandchild_comment = create(:comment,
                                  content: "TTYL",
                                  parent: child_comment,
                                  user: customer,
                                  commentable: feedback)

      render_inline(CommentComponent.with_collection([parent_comment]))

      expect(rendered_component).to have_selector "p.test-nesting-level-0", text: "OMG" # sanity test
      expect(rendered_component).to have_selector "div.test-nesting-level-1", text: "@george LOL"
      expect(rendered_component).to have_selector "div.test-nesting-level-2", text: "@bob TTYL"
    end
  end

  it "displays child comments in order" do
    customer = create(:customer, :avatared, username: "george")
    feedback = create(:feedback, user: customer)
    parent_comment = create(:comment, content: "OMG", user: customer, commentable: feedback)
    child_comment = create(:comment, content: "LOL", parent: parent_comment, user: customer, commentable: feedback)
    grandchild_comment = create(:comment, content: "TTYL", parent: child_comment, user: customer, commentable: feedback)

    render_inline(CommentComponent.with_collection([parent_comment]))

    expect(rendered_component).to have_text /OMG.*LOL.*TTYL/m
  end
end
