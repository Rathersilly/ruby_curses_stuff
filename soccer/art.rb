def s2da(s) # string to 2d array
  a = []
  s.each_line do |line|
    a << line.chomp.split('')
  end
  a
end
Art_u ="\
██    ██
██    ██
██    ██
██    ██
 ██████ "

Art_ua = s2da(Art_u)

Art_g = "\
 ██████   ██████   █████  ██      ██ ███████
██       ██    ██ ██   ██ ██      ██ ██     
██   ███ ██    ██ ███████ ██      ██ █████  
██    ██ ██    ██ ██   ██ ██      ██ ██     
 ██████   ██████  ██   ██ ███████ ██ ███████"

Art_ga = s2da(Art_g)

# R width
Art_r = "\
██████ 
██   ██
██████ 
██   ██
██   ██"
Art_ra = s2da(Art_r)
p Art_ra
# field is max 94 x
Field='
                                 +---------------------------+
                                 |\                          |\
                                 | \                         | \
                                 |  \                        |  \
_________________________________|___\_______________________|___\____________________________
            /                   /                           /                    /
           /                   /                           /                    /
          /                   /                           /                    /
         /                   /___________________________/                    /
        /                                                                    /
       /                                                                    /
      /                                                                    /
     /                                                                    /
    /____________________________________________________________________/'
 Field_a = s2da(Field)
 p Field_a[0]
 Field_a.each do |x|
   puts x.join
 end
 Field_a.each_with_index do |x, i|
   puts  "#{i}, #{x.length}"  # => 
 end
guy = <<-'EOF'
 O 
/|\
/ \
EOF

