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
  end

  describe "linking to self" do
    it "orphaned comments link to self" do
      customer = create(:customer, :avatared)
      feedback = create(:feedback, user: customer)
      comment = create(:comment, parent: nil, user: customer, commentable: feedback)

      render_inline(CommentComponent.with_collection([comment]))

      expect(rendered_component).to have_link nil, href: "#comment-#{comment.id}"
    end

    it "parented comments do not link to self" do
      customer = create(:customer, :avatared)
      feedback = create(:feedback, user: customer)
      parent_comment = create(:comment, parent: nil, user: customer, commentable: feedback)
      comment = create(:comment, parent: parent_comment, user: customer, commentable: feedback)

      render_inline(CommentComponent.with_collection([comment]))

      expect(rendered_component).not_to have_link nil, href: "#comment-#{comment.id}"
    end
  end

  describe "body indentation" do
    it "indents the body of an orphaned comment" do
      customer = create(:customer, :avatared, username: "george")
      feedback = create(:feedback, user: customer)
      comment = create(:comment, user: customer, commentable: feedback, content: "LOL")

      render_inline(CommentComponent.with_collection([comment]))

      expect(rendered_component).to have_selector "p.ml-12", text: "LOL"
    end

    it "flattens the body of parented comment" do
      customer = create(:customer, :avatared, username: "george")
      feedback = create(:feedback, user: customer)
      parent_comment = create(:comment, user: customer, commentable: feedback, content: "OMG")
      comment = create(:comment, parent: parent_comment, user: customer, commentable: feedback, content: "LOL")

      render_inline(CommentComponent.with_collection([comment]))

      expect(rendered_component).to have_selector "p.test-no-indentation", text: "LOL"
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
