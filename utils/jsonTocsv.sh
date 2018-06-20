# Comando para pasar json a csv

cat */*.json | jq -r '. | [.created_at, .user.screen_name, .user.name, .text, .id,.source,.user.followers_count, .user.friends_count, .retweet_count,.favorite_count,.user.verified ,.user.created_at, .user.location, .user.description, .user.profile_image_url] | @csv' > conapred3.csv
