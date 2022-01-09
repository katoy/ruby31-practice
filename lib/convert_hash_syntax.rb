# frozen_string_literal: true

def convert_hash_syntax(old_syntax)
  old_syntax.gsub(/:(\w+) *=> */) do
    "#{Regexp.last_match(1)}: "
  end
end

def convert_hash_syntax2(old_syntax, nest = 0)
  padding = '  ' * nest
  str = "{\n"

  eval(old_syntax).each do |k, v|
    str +=
      if v.instance_of?(Hash)
        "#{padding}  #{k.to_sym}: #{convert_hash_syntax2(v.to_s, nest + 1)},\n"
      else
        "#{padding}  #{k.to_sym}: '#{v}',\n"
      end
  end

  str += "#{padding}}"
  str += "\n" if nest.zero?
  str
end
