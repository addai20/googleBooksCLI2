# require 'pry'
require 'net/http'
require 'json'

class Main
  # Initialize data structures to store book data
  @@readingList = []
  @@searchResults = nil
  # User session is active as long as value of @@active == true
  @@active = true

  def rspecTest
    puts 0
    return 0
  end

  def self.sayGoodbye
    system("clear")
    puts "Goodbye and thank you for using book search!"
    puts "-----------------------End-Session---------------------------------------"

  end

  def self.promptSearch
    # prompts user for search query, stores in a variable
    puts "Please enter the name of an author or book"
    query = gets.chomp

    if query == nil || query == ""
      self.promptSearch()
    end
    # base url for api call concatenated with user input/search query
    uri = URI('https://www.googleapis.com/books/v1/volumes?key=AIzaSyBBt_puiZZJw7Q8Fl7jtupk6BvGGpKYMEI&maxResults=5&q=' + query)
    @@searchResults = JSON.parse(Net::HTTP.get(uri))["items"]

  end

  def self.clearTerminal
    # clears the terminal to promote better readability
    system("clear")
  end

  def self.displayInstructions
    # Displays navigation instructions
    puts "_____________________________NAVIGATION______________________________"
    puts "** To add to reading list, enter a number 1-5 that corresponds to your desired book"
    puts "** To start a new search, enter 6"
    puts "** To view reading list, enter 7"
    puts "** To exit, enter 8"
    puts "_____________________________________________________________________"
  end

  def self.displayBookData(bookDataArray)
    # Displays the book data, used for displaying search results and reading list data

    if @@searchResults == nil || @@searchResults.length == 0
      puts "There is no book data to display"
    else
    bookDataArray.each_with_index do |book, idx|
      puts "_____________________________________________________________________"
      puts (idx + 1).to_s + ": "
      puts formatBookData(book)
      end
    end
  end

  def self.formatBookData(book)
    # Displays the Author, Title and Publisher respectively
    puts "Author(s): #{book["volumeInfo"]["authors"]}"
    puts "Title: #{book["volumeInfo"]["title"]}"
    puts "Publisher: #{book["volumeInfo"]["publisher"]}"
  end

  def self.addToReadingList(selectedBook)
    @@readingList.append(@@searchResults[selectedBook.to_i - 1])
    clearTerminal()
    puts "#{@@searchResults[selectedBook.to_i - 1]["volumeInfo"]["title"]} has been added to reading list!"
    displayBookData(@@searchResults)
    handleUserInput()

  end

  def self.handleUserInput
    # displays instructions for how to navigate system
    displayInstructions()
    input = gets.chomp

  # This case handles options outlined in the instructions
    case input
      when "1"
        addToReadingList(input)

      when "2"
        addToReadingList(input)

      when "3"
        addToReadingList(input)

      when "4"
        addToReadingList(input)

      when "5"
        addToReadingList(input)
      when "6"
        clearTerminal()
        run()
      when "7"
        clearTerminal()
        if @@readingList.length == 0
          # If there are no books in reading list, display the following
          puts "There are no books in the Reading List!"
          displayBookData(@@searchResults)
          handleUserInput()
        else
          # otherwise, displays readingList
          clearTerminal()
          puts "_______________________BEGIN_READING_LIST_________________________"
          @@readingList.each_with_index do |book, idx|
            puts idx.to_s + ": "
            puts formatBookData(book)
            puts "------------------------------------------------------------------"

          end
          puts "_______________________END_READING_LIST___________________________"
          displayBookData(@@searchResults)
          handleUserInput()

        end
      when "8"
        # Exits the application
        clearTerminal()
        sayGoodbye()
        @@active = false
        run()
      else
        # If invalid response submitted, prompts user for a valid response
        clearTerminal()
        puts "Please enter a valid response"
        displayBookData(@@searchResults)
        handleUserInput()
      end

  end



  def self.run
    if @@searchResults == nil
      puts "---------------------Begin-Session---------------------------------------"
      # puts "Please enter the name of an author or book"
    end

    while @@active
      promptSearch()


      displayBookData(@@searchResults)
      # display navigation instructions for the interface..
      handleUserInput()

    end
  end

  # run()

end

# mainInstance = Main.new
# mainInstance.run



# DELIVERABLES

# 1)Type in a query and display a list of 5 books matching that query. ????????
#
# 2) Each item in the list should include the book's author, title, ????????
# and publishing company.
#
# 3) A user should be able to select a book from the five ????????
# displayed to save to a ???Reading List???
#
# 4) View a ???Reading List??? with all the books the user has selected from their queries ????????
# -- this is a local reading list and not tied to Google Books???s account features.
