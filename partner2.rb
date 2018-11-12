# Aufgabe a05_2
# Team ChillyCrabs
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'set'
require_relative 'adresse2'
include Comparable

# Stores name, surname and address of a person. Any changes to the address
# attribute also get applied to the corresponding address object.
class Partner2
  attr_reader :vorname, :name, :adresse
  protected :vorname, :name, :adresse

  # Sets instance attributes. In case the address is provided, it gets this
  # partner object added to its set.
  def initialize(vorname, nachname, adresse = nil)
    @vorname = vorname
    @name = nachname
    @adresse = adresse
    unless @adresse.nil?
      raise ArgumentError unless adresse.is_a?(Adresse2)
      @adresse.add_partner(self)
    end
  end

  # Sets the address for the partner object and adds this partner to the address
  # set. An existing address always gets its partner removed beforehand.
  def add_address(adresse)
    raise ArgumentError, 'Argument must be of type Adresse2' unless adresse.is_a?(Adresse2)
    return self if @adresse == adresse

    @adresse.remove_partner(self) unless @adresse.nil?
    @adresse = adresse
    @adresse.add_partner(self)
    self
  end

  # Removes this partner from the address instance and removes the reference to
  # that address.
  def remove_address
    return self if @adresse.nil?

    @adresse.remove_partner(self)
    @adresse = nil
    self
  end

  # String with name and surname
  def to_s
    "#{vorname} #{name}"
  end

  # Like to_s, but with the address.
  def full_details
    "#{vorname} #{name}#{', Adresse: ' unless @adresse.nil?}#{@adresse}"
  end





  def ==(other)
    return false if other.nil?
    return true if self.equal?(other)
    return false if self.class != other.class
    [@vorname, @name, @adresse] == [other.vorname, other.name, other.adresse]
  end

  def hash
    prime = 31
    result = 1
    result = prime * result + (@name.nil? ? 0 : @name.hash)
    result = prime * result + (@vorname.nil? ? 0 : @vorname.hash)
    prime * result + (@adresse.nil? ? 0 : @adresse.hash)
  end

  def eql?(other)
    return false if other.nil?
    return true if self.equal?(other)
    return false if self.class != other.class
    [@vorname, @name, @adresse].eql?([other.vorname, other.name, other.adresse])
  end

  def <=>(other)
    return 0 if @name == other.name &&
        @vorname == other.vorname
    if @name < other.name || @name ==
        other.name && @vorname < other.vorname
      return -1
    end
    if @name > other.name || @name ==
        other.name && @vorname > other.vorname
      1
    end
  end
end
