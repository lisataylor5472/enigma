require 'date'

module Keyable
  def generate_msg_key(key)
    if key == nil
      @key = 5.times.map{rand(5)}.join
    else
      key
    end
  end

  def generate_msg_date(date)
    if date == nil
      Date.today.strftime("%d%m%y") #"DDMMYY"
    else
      date
    end
  end

  def generate_offset_keys(message_date)
    offsets = {}
    offsets["A"] = offset_id(message_date)[0].to_i
    offsets["B"] = offset_id(message_date)[1].to_i
    offsets["C"] = offset_id(message_date)[2].to_i
    offsets["D"] = offset_id(message_date)[3].to_i
    offsets
  end

  def offset_id(message_date)
    (message_date.to_i ** 2).to_s.slice!(-4..-1)
  end

  def generate_cipher_keys(message_key)
    cipher_keys = {}
    cipher_keys["A"] = message_key[0..1].to_i
    cipher_keys["B"] = message_key[1..2].to_i
    cipher_keys["C"] = message_key[2..3].to_i
    cipher_keys["D"] = message_key[3..4].to_i
    cipher_keys
  end

  def generate_cipher_shift_keys(cipher_offsets, cipher_keys)
    cipher_keys.merge(cipher_offsets) {|key, keys, offsets| keys + offsets}.values
  end
end
