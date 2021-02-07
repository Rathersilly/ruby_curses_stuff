module Guys
lguy1 = <<-'EOF'
\O 
 |\
/ \
EOF
lguy2 = <<-'EOF'
 / 
 |\
/ \
EOF
lguy3 = <<-'EOF'
 O 
 \\
/ \
EOF
lguy4 = <<-'EOF'
 O 
/|\
/ \
EOF
rguy1 = <<-'EOF'
 O/
/| 
/ \
EOF
rguy2 = <<-'EOF'
 \ 
/| 
/ \
EOF
rguy3 = <<-'EOF'
 O 
// 
/ \
EOF
rguy4 = <<-'EOF'
 O 
/|\
/ \
EOF

  LGUY = [lguy1, lguy2, lguy3, lguy4].cycle.to_enum
  RGUY = [rguy1, rguy2, rguy3, rguy4].cycle.to_enum
end
#x = 0
#delay = 0.1
#loop do
  #system('clear')
  #puts lguy.next
  #sleep delay
#end


