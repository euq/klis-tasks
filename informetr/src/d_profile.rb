#! ruby -Ks

#変更用変数,
loopn = 100  # 刻み幅


#配列に格納
arr = Array.new
n = 0
while line = gets
  line.chomp!
  arr.push(line)
  n += 1
end

#繰り返しのカウントと，各回の平均を入れる配列
j = 0
n_vn = Array.new(0)

#各回のサンプル語数を固定
#n20 = n / 20
n20 = 200  # 刻み幅
partition = n / n20

sum1 = Array.new(0)
sum2 = Array.new(0)
ep = Array.new(0)

E = Array.new(0)
K = Array.new(0)
D = Array.new(0)

iii = 0
while iii < loopn
	count_w = Hash.new(0)

	print(iii,"\n")

	arr_r = arr.sort_by{|i| rand }

	ii = 0
	while ii < (partition + 1)

		if ii < partition
			endpoint=(ii+1)*n20-1
		else
			endpoint=n-1
		end
		ep.push(endpoint)

		#ハッシュ：出現回＝＞個数
		vmn = Hash.new(0)	#ループの外じゃなくてもよい？

		i=ii*n20
  
		while i <= endpoint
		#  while i <= (ii+1)*n20-1

		#ハッシュ：単語＝＞出現回
		count_w[arr_r[i]] += 1
		i += 1
		end

		count_w.each{|key, value|
		vmn[value] += 1
		}
  
		#vn
		vn = count_w.length

		sum1.push(vn)
		sum2.push(i/vn.to_f)

#l = 1
#while l <= endpoint
#	
#	logarithm = Math.log(l/endpoint)
#	index = l/endpoint
#
#	E += vmn[l] * (-logarithm) * index;
#	K += (10 ** 4) * ((-1/endpoint) + vmn[l] * index ** 2)
#end
#
#while l < vmn.length
#
#	D += vmn[l] * (l/endpoint) * ((l-1)/(endpoint-1)) 
#
#end
#
#E.push(E)
#K.push(K)
#D.push(D)

		ii += 1
	end
	iii += 1

end

print("#\tN\tV(N)\tV(N)/N [TTR]\n")

ii = 0
while ii < (partition + 1)
	jj = 0
	vn = 0
	while jj < loopn
		vn += sum1[(partition + 1)*jj+ii]
		jj += 1
	end
	vn = vn/loopn
	print(ii,"\t",ep[ii],"\t",vn,"\t",vn/ep[ii].to_f,"\n")
	ii += 1

end


#print(sum/loop.to_f)
#
