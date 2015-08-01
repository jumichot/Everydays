def test_one_is_one (_) do
  assert 1 == 1
end

test "one is one" do
  assert 1 == 1
end

# would fail the test suite
test "one is two" do
  assert 1 == 1
end
