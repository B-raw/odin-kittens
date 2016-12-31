require 'test_helper'

class KittensControllerTest < ActionDispatch::IntegrationTest
  def setup
    @bubbles = kittens(:bubbles)
    @puss    = kittens(:puss)
  end

  test "it can list kittens" do
    get kittens_path
    assert_template 'kittens/index'
    assert_select 'li>p', @bubbles.name
    assert_select 'li>p', @puss.name
    assert_select 'a[data-method="delete"]', 'Delete Kitten'
  end

  test "it can click kitten to go to show page" do
    get kittens_path
    assert_select 'a[href=?]', kitten_path(@bubbles), text: @bubbles.name
    assert_select 'a[href=?]', kitten_path(@puss), text: @puss.name
  end

  test "it can show a single kitten" do
    get kitten_path(@bubbles)
    assert_template 'kittens/show'
    assert_select 'h1', text: @bubbles.name
    assert_select 'p', text: "My age: #{@bubbles.age}"
    assert_select 'h1', text: @puss.name, count: 0
  end

  test "it can add a new kitten via form" do
    get new_kitten_path
    assert_select "form[action='/kittens']"
    assert_difference 'Kitten.count', 1 do
      post kittens_path, params: { kitten: { name: "Jill", age: 12, cuteness: 8, softness: 5 }}
    end
    follow_redirect!
    assert_not flash.empty?
    assert_template 'kittens/show'
  end

  test "it can edit a new kitten via a form" do
    get edit_kitten_path(@bubbles)
    assert_select "form[action='/kittens/#{@bubbles.id}']"
    assert_select "input[value='patch']"
    name  = "Foo Bar"
    age = 20
    patch kitten_path(@bubbles), params: { kitten: { name: name, age: age, cuteness: 8, softness: 5 }}
    assert_redirected_to @bubbles
    assert_not flash.empty?
    @bubbles.reload
    assert_equal name, @bubbles.name
    assert_equal age, @bubbles.age
  end

  test "delete link shows on show and edit pages and they work" do
    get edit_kitten_path(@bubbles)
    assert_select 'a[data-method="delete"]', 'Delete Kitten'
    get kitten_path(@bubbles)
    assert_select 'a[data-method="delete"]', 'Delete Kitten'
    assert_difference 'Kitten.count', -1 do
      delete kitten_path(@bubbles)
    end
    assert_redirected_to kittens_path
    assert_not flash.empty?
  end
end
