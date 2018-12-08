def solve(input)
  entries, states = input.chars.reduce([[[]], []]) {|(entries, states), c|
    # puts "entities: #{entries}, states: #{states}, c: #{c}"
    case states.last
    when '/'
      if c == '/' && entries.last.last == '/'
        [entries, states[0...-1]]
      else
        e = entries.pop
        entries.push(e[0...-1])
        entries.push([])
        states.pop
        # puts "entities: #{entries}, states: #{states}, c: #{c}"
        case c
        when '"'
          [entries, states.push('"')]
        when "'"
          [entries, states.push("'")]
        else
          entries.last.push(c)
          [entries, states]
        end
      end
    when '"'
      case c
      when '/'
        entries.last.push('/')
        [entries, states]
      when '"'
        [entries, states[0...-1]]
      when "'"
        entries.last.push("'")
        [entries, states]
      else
        entries.last.push(c)
        [entries, states]
      end
    when "'"
      case c
      when '/'
        entries.last.push('/')
        [entries, states]
      when '"'
        entries.last.push('"')
        [entries, states]
      when "'"
        [entries, states[0...-1]]
      else
        entries.last.push(c)
        [entries, states]
      end
    else
      case c
      when '/'
        entries.last.push('/')
        [entries, states.push('/')]
      when '"'
        [entries, states.push('"')]
      when "'"
        [entries, states.push("'")]
      else
        entries.last.push(c)
        [entries, states]
      end
    end
  }

  return '-' unless states.empty?
  return '-' if entries.any? {|e| e.empty? }
  entries.map(&:join).join(',')
end

def test(input, expected)
  actual = solve(input)

  if expected == actual
    puts "passed: #{expected}"
  else
    puts "failed: input: [#{input}], expected: [#{expected}], actual: [#{actual}]"
  end
end

test( "foo/bar/baz", "foo,bar,baz" )
test( "/foo/bar/baz'/", "-" )
test( "\"", "-" )
test( "'", "-" )
test( "/", "-" )
test( "\"\"", "-" )
test( "''", "-" )
test( "//", "/" )
test( "\"/'", "-" )
test( "'/\"", "-" )
test( "Qux", "Qux" )
test( "Foo/Bar", "Foo,Bar" )
test( "foo\"bar", "-" )
test( "foo'bar", "-" )
test( "/foo/bar", "-" )
test( "Foo//Bar", "Foo/Bar" )
test( "foo/bar/", "-" )
test( "'\"'a'\"'/b", "\"a\",b" )
test( "Foo\"/\"Bar", "Foo/Bar" )
test( "foo\"'\"bar", "foo'bar" )
test( "foo'\"'bar", "foo\"bar" )
test( "foo///bar", "foo/,bar" )
test( "\"Z\"\"tO\"uFM", "ZtOuFM" )
test( "''/foo/bar", "-" )
test( "////'/\"//'", "///\"//" )
test( "File/'I/O'", "File,I/O" )
test( "Foo'//'Bar", "Foo//Bar" )
test( "foo/''/bar", "-" )
test( "foo/bar/\"\"", "-" )
test( "'/////'////", "///////" )
test( "'foo\"\"\"bar'", "foo\"\"\"bar" )
test( "//'int'/V/c", "/int,V,c" )
test( "foo/bar/baz", "foo,bar,baz" )
test( "'H//Sg//zN'/", "-" )
test( "//'//\"/'/'\"'", "///\"/,\"" )
test( "foo//bar/baz", "foo/bar,baz" )
test( "\"\"\"///\"/'/'//", "///,//" )
test( "58\"\"N\"//nIk'd", "-" )
test( "foo\"/\"bar/baz", "foo/bar,baz" )
test( "/////'\"/'/'\"/'", "//,\"/,\"/" )
test( "f\"//J\"/O9o\"//'", "-" )
test( "foo\"//\"bar/baz", "foo//bar,baz" )
test( "foo/bar////baz", "foo,bar//baz" )
test( "\"\"\"'/'//'''/\"//", "'/'//'''//" )
test( "8//'/k///\"3da\"'", "8//k///\"3da\"" )
test( "foo/'/bar/'/baz", "foo,/bar/,baz" )
test( "///''\"//\"\"///\"\"\"", "/,/////" )
test( "//wUJ8KNAk'n0//\"", "-" )
test( "What/is/'\"real\"'", "What,is,\"real\"" )
test( "\"//'/////\"''/'//'", "//'/////,//" )
test( "\"8hKE\"3Fx/4//Hk/J", "8hKE3Fx,4/Hk,J" )
test( "'////''\"'//'/\"///'", "////\"//\"///" )
test( "Ro\"/j''/2u/f/r/\"3n", "Ro/j''/2u/f/r/3n" )
test( "hoge\"//\"fuga//piyo", "hoge//fuga/piyo" )
test( "'foo//bar'//baz/qux", "foo//bar/baz,qux" )
test( "//'//\"'/\"///'\"/''//", "///\",///',/" )
test( "2/L'3'A8p/7//wP49Jb", "2,L3A8p,7/wP49Jb" )
test( "\"foo'\"/\"bar'\"/\"baz'\"", "foo',bar',baz'" )
test( "'//'\"//'///'///''\"//", "////'///'///''/" )
test( "F6vX/q/Zu//5/'/H\"/'w", "F6vX,q,Zu/5,/H\"/w" )
test( "\"foo'bar\"/'hoge\"fuga'", "foo'bar,hoge\"fuga" )
test( "/\"/'//'/\"\"\"''//'/\"'''", "-" )
test( "0gK\"koYUb\"\"S/p''z/\"Et", "0gKkoYUbS/p''z/Et" )
test( "Foo/Bar/\"Hoge'/'Fuga\"", "Foo,Bar,Hoge'/'Fuga" )
