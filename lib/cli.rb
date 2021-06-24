require 'pry'
# debugging tool
require 'net/http'
# tool for working retrieving API  data
require 'json'
# tool for formatting data retreived from API in Javascript Object Notation


# Initialize data structures to store book data
$readingList = []
$searchResults = nil

# User session is active as long as value of $active == true
# Will use this variable to stop application
$active = true


def sayGoodbye
  system("clear")
  puts "Goodbye and thank you for using book search!"
  puts "-----------------------End-Session---------------------------------------"

end

def promptSearch
  # prompts user for search query, stores in a variable
  puts "Please enter the name of an author or book"
  query = gets.chomp
  # base url for api call concatenated with user input/search query
  uri = URI('https://www.googleapis.com/books/v1/volumes?key=AIzaSyBBt_puiZZJw7Q8Fl7jtupk6BvGGpKYMEI&maxResults=5&q=' + query)
  $searchResults = JSON.parse(Net::HTTP.get(uri))["items"]

end

def clearTerminal
  # clears the terminal to promote better readability
  system("clear")
end

def instructions
  # Displays navigation instructions
  puts "_____________________________NAVIGATION______________________________"
  puts "** To add to reading list, enter a number 1-5 that corresponds to your desired book"
  puts "** To start a new search, enter 6"
  puts "** To view reading list, enter 7"
  puts "** To exit, enter 8"
  puts "_____________________________________________________________________"
end

def displayBookData(bookDataArray)
  # Displays the book data, used for displaying search results and reading list data
  bookDataArray.each_with_index do |book, idx|
    puts "_____________________________________________________________________"
    puts (idx + 1).to_s + ": "
    puts formatBookData(book)

  end
end

def formatBookData(book)
  # Displays the Author, Title and Publisher respectively
  puts "Author(s): #{book["volumeInfo"]["authors"]}"
  puts "Title: #{book["volumeInfo"]["title"]}"
  puts "Publisher: #{book["volumeInfo"]["publisher"]}"
end

def handleQuery
  # displays instructions for how to navigate system
  instructions()

  # collects user input to execute instructions
  input = gets.chomp

# This case handles options outlined in the instructions
  case input
    when "1"
      # saves the first book in the searchResults array to the readingList array...
      $readingList.append($searchResults[input.to_i])
      clearTerminal()
      # binding.pry
      puts "#{$searchResults[input.to_i]["volumeInfo"]["title"]} has been added to reading list!"
      displayBookData($searchResults)
      handleQuery()

    when "2"
      $readingList.append($searchResults[input.to_i])
      clearTerminal()
      puts "#{$searchResults[input.to_i]["volumeInfo"]["title"]} has been added to reading list!"
      displayBookData($searchResults)
      handleQuery()

    when "3"
      $readingList.append($searchResults[input.to_i])
      clearTerminal()
      puts "#{$searchResults[input.to_i]["volumeInfo"]["title"]} has been added to reading list!"
      displayBookData($searchResults)
      handleQuery()

    when "4"
      $readingList.append($searchResults[input.to_i])
      clearTerminal()
      puts "#{$searchResults[input.to_i]["volumeInfo"]["title"]} has been added to reading list!"
      displayBookData($searchResults)
      handleQuery()

    when "5"
      $readingList.append($searchResults[input.to_i])
      clearTerminal()
      puts "#{$searchResults[input.to_i]["volumeInfo"]["title"]} has been added to reading list!"
      displayBookData($searchResults)
      handleQuery()
    when "6"
      clearTerminal()
      # Prompts the user for another search query..
      run()
    when "7"
      # Displays readingList
      clearTerminal()
      if $readingList.length == 0
        # If there are no books in reading list, display the following
        puts "There are no books in the Reading List!"
        displayBookData($searchResults)
        handleQuery()
      else
        # otherwise, displays readingList
        clearTerminal()
        puts "_______________________BEGIN_READING_LIST_________________________"
        $readingList.each_with_index do |book, idx|
          puts idx.to_s + ": "
          puts formatBookData(book)
          puts "------------------------------------------------------------------"

        end
        puts "_______________________END_READING_LIST___________________________"
        displayBookData($searchResults)
        handleQuery()

      end
    when "8"
      # Exits the application
      clearTerminal()
      sayGoodbye()
      $active = false
      run()
    else
      # If invalid response submitted, prompts user for a valid response
      puts "Please enter a valid response"
      puts "Press any number to return to the search results"
      handleQuery()
    end

end



def run
  if $searchResults == nil
    puts "---------------------Begin-Session---------------------------------------"
    # puts "Please enter the name of an author or book"
  end

  while $active
    promptSearch()


    displayBookData($searchResults)

    # display navigation instructions for the interface..
    handleQuery()

  end
end

run()



# DELIVERABLES

# 1)Type in a query and display a list of 5 books matching that query. 👌🏾
#
# 2) Each item in the list should include the book's author, title, 👌🏾
# and publishing company.
#
# 3) A user should be able to select a book from the five 👌🏾
# displayed to save to a “Reading List”
#
# 4) View a “Reading List” with all the books the user has selected from their queries 👌🏾
# -- this is a local reading list and not tied to Google Books’s account features.
