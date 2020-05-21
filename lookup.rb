require 'yaml'
#write to a file
#opens file in write mode ("w") (to append use "a")
$twoots = File.open("twoots.txt","a")
$all_twoots = File.open("twoots.txt","r")

#before YAML
#$lookup = Hash.new{|hash,key| hash[key] = []}

#read from YAML file
$lookup = YAML.load(File.read("twoot_base.yml"))

def post_twoot(message,handle)#writes a twoot and hashes its hashtags
  $twoots.write(message + "-" + handle + "\n")
  tags = find_hashtags(message)
  for i in 0...tags.length
    $lookup[tags[i]].append(message)
    #write to YAML
    File.open("twoot_base.yml", "w"){|file| file.write($lookup.to_yaml)}
  end
end

def find_hashtags(message)#finds the hashtags in a twoot
  hashtags = []
  last_i = -1
  for i in 0...message.length
    last_i = i if message[i] == '#'
    if last_i != -1 and (message[i] == ' ' or i == message.length - 1)
      hashtags.append(message[last_i..i].strip)
      last_i = -1
    end
  end
  return hashtags
end

def lookup_hashtag(hashtag)
  all_messages_with_hashtag = $lookup[hashtag]
end
#posting a twoot
#post_twoot "#NewYork has so many views. #Blessed", "steph"
#post_twoot "#Blessed to talk with you all at the convention last saturday!", "jessica"
#post_twoot "Unbelievable #views during the #sunset" , "brian"
#post_twoot "The #views from that house I looked at was #awesome", "jim"

#looking up a hashtag
p lookup_hashtag("#views")


=begin
  resources used:
  https://www.rubyguides.com/2015/05/working-with-files-ruby/
  https://docs.ruby-lang.org/en/2.0.0/Hash.html
=end
