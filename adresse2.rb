# Aufgabe a05_2
# Team ChillyCrabs
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'set'
require_relative 'partner2'

# Stores street, street number, postal code, city and country of an address, as
# well as its residetns. All changes to the residents also get applied to their
# corresponding objects.
class Adresse2
  attr_reader :plz, :stadt, :strasse, :land, :hausnr
  protected :plz, :stadt, :strasse, :land, :hausnr
  include Comparable

  def initialize(strasse, hausnr, plz, stadt, land)
    @strasse = strasse
    @hausnr = hausnr
    @plz = plz
    @stadt = stadt
    @land = land
    @partners = Set.new
  end


  # Adds a new partner to the partners set, unless the partner already exists in
  # this set. The partners address is set to this object.
  def add_partner(partner)
    raise ArgumentError, 'Argument must be of type Partner2' unless partner.is_a?(Partner2)

    unless @partners.include?(partner)
      partner.add_address(self)
      @partners.add(partner)
    end
    self
  end

  # Removes a partner object from the partners set if it is found there and
  # removes this address from its attributes.
  def remove_partner(partner)
    raise ArgumentError, 'Argument must be of type Partner2' unless partner.is_a?(Partner2)

    partner.remove_address unless @partners.delete?(partner).nil?
  end

  # Returns true if partner is included in this object, i.e. in @partners.
  def include_partner?(partner)
    @partners.include?(partner)
  end

  # Returns a String containing all address information.
  def to_s
    "#{@strasse} #{@hausnr}, #{@plz} #{@stadt}, #{@land}"
  end

  # Returns a String containing all partners registered under this address.
  def partners_to_s
    @partners.sort.to_a.join("\n")
  end

  # Iterates over the @partners set.
  def each(&block)
    @partners.each(&block)
  end






  def ==(other)
    return false if other.nil?
    return true if self.equal?(other)
    return false unless self.class == other.class
    [@strasse, @hausnr, @plz, @stadt, @land] ==
        [other.strasse, other.hausnr, other.plz, other.stadt, other.land]
  end

  def hash
    prime = 31
    result = 0
    result = prime * result + (@strasse.nil? ? 0 : @strasse.hash)
    result = prime * result + (@hausnr.nil? ? 0 : @hausnr.hash)
    result = prime * result + (@plz.nil? ? 0 : @plz.hash)
    result = prime * result + (@stadt.nil? ? 0 : @stadt.hash)
    prime * result + (@land.nil? ? 0 : @land.hash)
  end

  def eql?(other)
    return false if other.nil?
    return true if self.equal?(other)
    return false unless self.class == other.class
    [@strasse, @hausnr, @plz, @stadt, @land].eql?(
        [other.strasse, other.hausnr, other.plz, other.stadt, other.land])
  end

  #def <=>(other)
   # [@plz]<=>[other.plz]
  #end

  # def succ
   # Adresse2.new(@strasse, @hausnr,(@plz + 1), @stadt, @land)
  #end
end
