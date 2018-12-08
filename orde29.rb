def solve(input)
  input.upcase
end

DATA.each do |test_case|
  n, input, expected = test_case.split(/[\/\*\(\),";]|test/).map(&:strip).reject {|s| s == '' }

  actual = solve(input)

  if expected == actual
    puts "#{n} passed"
  else
    puts "#{n} failed: expected: #{expected}, actual: #{actual}"
  end
end

__END__
/* 0 */ test("abc", "ABC");
