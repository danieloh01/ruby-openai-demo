require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

# message_list = [
#   {
#     "role" => "system",
#     "content" => "You are a very helpful assistant that likes to speak very passionately"
#   },
#   {
#     "role" => "user",
#     "content" => "Hello, what are the best spots for Japanese food in New York City?"
#   }
# ]

# api_response = client.chat(
#   parameters: {
#     model: "gpt-3.5-turbo",
#     messages: message_list
#   }
# )

message_list = [
    {
      "role" => "system",
      "content" => "You are a very helpful assistant that likes to speak very passionately"
    }
  ]

puts "Hello. How can I help you today?"
puts "-" * 50

user_input = ""

while user_input != "bye"

  user_input = gets.chomp.gsub(" ","%20")
  
  if user_input != "bye"
    message_list.push({ "role" => "assistant", "content" => user_input })

    api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )

    specific_1 = api_response.fetch("choices")
    specific_2 = specific_1.at(0)
    specific_3 = specific_2.fetch("message")
    specific_4 = specific_3["content"]


    puts "-" * 50
    pp specific_4
    
    message_list.push({ "role" => "assistant", "content" => specific_4 })

  end
end
