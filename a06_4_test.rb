# Aufgabe a06_4
# Team ChillyCrabs
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'test/unit'
require_relative 'adresse2'
require_relative 'partner2'

class A064Test < Test::Unit::TestCase

  def setup
    @a1 = Adresse2.new('A-Weg', '1a', '11111', 'Aachen', 'Argentinien')
    @a2 = Adresse2.new('B-Weg', '2b', '22222', 'Bochum', 'Bolivien')
    @a3 = Adresse2.new('C-Weg', '3c', '33333', 'Chemnitz', 'Chile')
    @a4 = Adresse2.new('D-Allee', '4d','44444', 'Dresden', 'Daenemark')
    @p1 = Partner2.new('Erster', 'Partner', @a1)
    @p2 = Partner2.new('Zweiter', 'Typ', @a2)
    @p3 = Partner2.new('Dritter', 'Mensch', @a3)
    @p4 = Partner2.new('Vierter', 'Kunde', @a4)
    @p5 = Partner2.new('Fünftes', 'Wesen', @a4)
    @p6 = Partner2.new('Sechster', 'Muggle', @a4)
  end

  def test_addresses
    assert_true(@p1.full_details == "#{@p1.to_s}, Adresse: #{@a1}")
    assert_true("#{@p1.to_s}, Adresse: #{@a1}" == @p1.full_details)
    assert_true(@a1.include_partner?(@p1))
    assert_true(@a2.include_partner?(@p2))
    assert_false(@a1.include_partner?(@p2))
    assert_false(@a2.include_partner?(@p1))

    # add and remove to address
    assert_equal(@p1.to_s, @a1.partners_to_s)

    @a1.remove_partner(@p1)
    assert_equal('', @a1.partners_to_s)
    assert_not_equal(@p1.to_s, @a1.partners_to_s)

    @a1.add_partner(@p1)
    assert_not_equal('', @a1.partners_to_s)
    assert_equal(@p1.to_s, @a1.partners_to_s)

    # move partner from one to another address
    assert_equal(@p2.to_s, @a2.partners_to_s)
    assert_equal("Zweiter Typ, Adresse: #{@a2}", @p2.full_details)
    @a1.add_partner(@p2)
    assert_equal("Zweiter Typ, Adresse: #{@a1}", @p2.full_details)
    assert_equal("#{@p1.to_s}\n#{@p2.to_s}", @a1.partners_to_s)
    assert_equal("Erster Partner\nZweiter Typ", @a1.partners_to_s)
    assert_equal('', @a2.partners_to_s)

    # assign address to partner
    assert_equal('Dritter Mensch', @a3.partners_to_s)
    assert_equal("Dritter Mensch, Adresse: #{@a3}",@p3.full_details)
    @p3.add_address(@a1)
    assert_equal('', @a3.partners_to_s)
    assert_equal("Dritter Mensch\nErster Partner\nZweiter Typ", @a1.partners_to_s)
    assert_equal("Dritter Mensch, Adresse: #{@a1}",@p3.full_details)

    #remove address from partner
    @p3.remove_address
    assert_equal("Erster Partner\nZweiter Typ", @a1.partners_to_s)
    assert_equal('Dritter Mensch', @p3.full_details)

    # Errors
    assert_raise (ArgumentError) {@p1.add_address(5) }
    assert_raise (ArgumentError) {@a1.add_partner(5)}
    assert_raise (ArgumentError) {Partner2.new('a', 'b', 5)}
  end

  def test_each
    @a1.add_partner(@p2).add_partner(@p3)
    assert_true(@a1.include_partner?(@p1))
    assert_true(@a1.include_partner?(@p2))
    assert_true(@a1.include_partner?(@p3))
    string = ''
    @a1.each {|x| string << x.to_s}
    assert_equal("#{@p1.to_s}#{@p2.to_s}#{@p3.to_s}", string)
    assert_equal('Erster PartnerZweiter TypDritter Mensch', string)
  end
    # Tests sorting by surname and forename
  def test_sorting
    @a1.add_partner(@p2)
    @a1.add_partner(@p3)
    @a1.add_partner(@p4)
    @a1.add_partner(@p5)
    @a1.add_partner(@p6)
    assert_equal(@a1.partners_to_s, "Vierter Kunde\nDritter Mensch\nSechster Muggle\nErster Partner\nZweiter Typ\nFünftes Wesen")
  end
end
