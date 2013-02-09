##
# class to manage list of contacts
#
class Contacts

  ##
  # create a Contacts object from string of pipe delimited ("|") fields, one record per line
  # e.g. "Brandon Faloona|Seattle|WA|bfaloona@uw.edu\nBarack Obama|Washington|DC|president@wh.gov"
  #
  def initialize data
    @raw_entries = data.split("\n")
    # set @contacts to an array of contacts
    @contacts = @raw_entries.collect do |line|
      contact_hash line
    end
  end

  def raw_entries
    @raw_entries
  end

  # the list of fields expected in input lines

  def fields
    [:full_name, :city, :state, :email]
  end


  # create a contact (a hash) from raw input line

  def contact_hash line
    values = line.split("|")
    Hash[fields.zip values]
  end

  ##
  # return a comma separated list of formatted email addresses
  #
  def email_list
    @raw_entries.collect do |line|
      name, city, state, email = line.split("|")
      format_email_address name, email.chomp
    end.join(", ")
  end

  ##
  # returns "Display Name" <email@address> given name and email
  #
  def format_email_address name, email
    %{\"#{name}\" <#{email}>}
  end

  def num_entries
    @raw_entries.length
  end

  def contact index
    @contacts[index.to_i]
  end

  #########

  def format_contact contact
     #"#{contact[:full_name]} of #{contact[:city]} #{contact[:state]}" <#{contact[:email]}>
    %{"#{contact[:full_name]} of #{contact[:city]} #{contact[:state]}" <#{contact[:email]}>}
  end

  def all
    @contacts
  end

  def formatted_list
    @contacts
    all.collect {|contact| format_contact }.join("\n")   #need better explanation on join
  end

  def full_names
    all.collect {|contact| contact[:full_name] }
  end

  def cities
    all.collect {|array| array[:city]}.uniq           # subject.cities.should eq %w(Seattle Washington) uniq or uniq! ???
  end

  def append_contact contact
    @contacts << contact
  end

  def delete_contact index
    @contacts.delete_at(index)
  end

  def search term_name
    @contacts
    contacts.select {|hash| hash.has_value? search_term}
  end

  def all_sorted_by field        #w.sort      w.sort {|a,b| b<=>a }
    all.sort {|a,b| a[field] <=> b[field]}
  end
end

  

