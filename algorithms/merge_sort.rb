def merge_sort(list)
  return list if list.size <= 1

  mid = list.size / 2
  left = merge_sort(list[0...mid])
  right = merge_sort(list[mid..-1])

  merge(left, right)
end

def merge(left, right)
  new_list = []
  until left.empty? || right.empty?
    if left.first <= right.first
      new_list << left.shift
    else
      new_list << right.shift
    end
  end
  new_list + left + right
end

puts merge_sort([5, 4, 3, 2, 1])