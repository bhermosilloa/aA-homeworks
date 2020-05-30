I gave this project a try by myself, but got stuck.

As I'm doing the free bootcamp, I don't have a TA to rely on. So, I downloaded
the solution to get some guidance.

You will see that some code is similar or the same as the solution, mainly on 
the display methods, but the logic of the hands methods is entirely mine. 

I gave all cards a color to display on the terminal using the colorize gem. Rspec
doesn't support this gem so I had to commented it out and go with a black and white
design on cards. 

I also added a timer so when two or more players are facing each other, they won't 
see their opponent's cards. It is also commented out, but you can activate it anytime.

About the tiebreaker on same hands, I didn't apply the suit tiebreaker, as normally it
is not used in most poker games. Rather I just went with high card tiebreaker and that's it.
Because of this, the Array#delete method didn't work with my Hand#throw_cards_away method, as
it selected and deleted cards with the same rank value. So I monkey patched the Array#delete method
to delete the selected objects in an Array only when they had the same object_id.

