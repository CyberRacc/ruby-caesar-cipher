# Notes & Difficulties

One of the main things I struggled on was the maths aspect, and the logic behind *normalising* the `ASCII` numbers to a range between 0 and 25 to represent the 26 letters of the alphabet.

## The Problem
I needed to create a Caesar cipher, which seemed straight forward at first. I was able to create a cipher pretty quick that took a `string` and a `shift_by` value as parameters.

This initial try simply `split('')` the string into an array. Then using the `#each` method I iterated over each element in that array (i.e. each alphabet character), which I checked for using an `if` statement with a `match?` predicate method on the array.

**Example:**
```rb
def caesar_cipher(message, shift_by)
	ciphered_message = []

	message.split('').each do |substring|
		if substring.match?(/[A-Za-z]/)
			shifted_substring = substring.ord + shift_by
			ciphered_message.push(shifted_substring.chr)
		else
			ciphered_message.push(substring)
	end
	return ciphered_message
end
```

That is all well and good but the complication comes when you want to wrap back around the alphabet, as with the current solution, you can end up with non-alphabetical symbols.

To solve this, we need a way to wrap the substrings back around the alphabet when they go beyond `"Z"` or `"z"`.

This is where it gets a bit complex.

## The Solution
The way we can solved this issue is to *normalise* the `ASCII` numbers down to a range of **0-25** first, then we can have a check for if the shifted number goes beyond 25, if so then **wrap** it back around to the start of the alphabet range.

The way I did this was to create a new method that would handle the normalisation:

```rb
def normalise_ascii_input(ascii_input)
  # Normalise the input number to a range between 0-25
  if ("A".ord.."Z".ord).include?(ascii_input)
    ascii_number = ascii_input - "A".ord
  elsif ("a".ord.."z".ord).include?(ascii_input)
    ascii_number = ascii_input - "a".ord
  end
  return ascii_number
end
```

This does what we want. But how exactly?

We have to have two checks, one for uppercase characters and one for lowercase characters, this is because they start and end at different ranges.

**Ranges:**
- **A-Z**: `65..90`
- **a-z**: `97..122`

In my method, I have used `("A".ord.."Z".ord)` and `("a".ord.."z".ord)` to get the range as I wasn't sure what the exact ranges were at first.

To convert these into a range of 0-25, we simply **subtract** the `("A".ord)` value (or `65`) from the `ascii_input` (which has already been converted using `.ord` before being passed to this method), for uppercase letters, and for lowercase letters we just use the `("a".ord)` value (or `97`).

Therefore no matter if it is an uppercase letter or lowercase, we get a value that is between 0 and 25 inclusive.

Where `0` is `a` and `A`, `1` is `b` and `B`, etc.

Some examples of this:
- Normalise `"A".ord`.
	- If our `ascii_input` is value `65` for the uppercase "A" character, then `ascii_input - ("A".ord)` would equal 0.
- Normalise `"a".ord`.
	- If our `ascii_input` is value `97` for the lowercase "a" character, then `ascii_input - ("a".ord)` would also equal 0.
- Normalise `"Z".ord`.
	- If our `ascii_input` is value `90` for the uppercase "Z" character, then `ascii_input - ("A".ord)` would equal 25.
- Normalise `"z".ord`.
	- If our `ascii_input` is value `122` for the lowercase "z" character, then `ascii_input - ("a".ord)` would also equal 25.

From these examples we can see that we'd always have a value of between 0 and 25.

Now we understand how to normalise it.

## Wrapping the range.

The next thing I struggled to understand with this Caesar cipher is the actual wrapping of the range when it goes above 25.

**I used this:**
```rb
shifted_number = (normalised_ascii_number + shift_by) % 26 # Always modulo by 26 to ensure wrapping with any number
```

This is where the shift happens.

We take the return value of the `normalise` method, add the `shift_by` value, and modulo by 26 to get the final `shifted_number` value.

The `modulo` calculation is essential for the wrapping to work, it's what makes the wrapping actually happen.

If the number is less than 26, it will simple return the initial value like so:
```rb
irb(main):007> 21 % 26
=> 21
irb(main):008> 19 % 26
=> 19
irb(main):009> 18 % 26
=> 18
irb(main):010> 32 % 26
=> 6
irb(main):011> 28 % 26
=> 2
irb(main):013> 26 % 26
=> 0
```

But when the value goes to 26 or above, the value goes back to 0.

This is why we modulo every number, instead of checking if the value goes above 26 first.

## Final Notes
My weaknesses when coding mostly come down to the logic of mathematical operations. Or, the **why** of doing these things.

I need to create more notes like these for future projects when I am stuck on a problem for a while, to wrap my head around it.

If you have randomly stumbled upon this repository or are here from the Odin project solutions page, I hope this was of some help to you actually understand what you're doing.

I had actually zero programming knowledge before joining The Odin Project, so being able to make these things is a huge win.
