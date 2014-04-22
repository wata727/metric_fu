# coding: utf-8
class SomeClass
  def initialize(a,b,c)
    "hey, invalid ASCII\xED"
  end
end
