mutable struct MQR
	Q::Any
	R::Any
	U::Any
	V::Any
end










"""`out=mqr(U;p=[])`

Author: Pilwon Hur, Ph.D.

Modified qr decomposition

If m>=n, then it's the same as qr()

If m<n, then generic qr does not care of the column order of Q matrix

mqr(U) will keep the column order of Q up to the level of rank.

In other words, the first r columns of Q are orthonomal vectors for the Range(U)

Within th Range(U), the order is not guaranteed to be the same as the column order of U.

However, it tends to keep the order if possible.

If you want to specify the order, then put the permutation information in p.

Ex) 
```julia 
out=mqr(U,p=[1,2])
out=mqr(U) # when you don't care about the order of the first 2 columns
out.Q
out.R
out.U
out.V
```

where `out.U=Q[1:r]`, `out.V=out.U perp`

In this case, the first 2 columns of U will be applied to the first 2 columns of Q with the same order.
"""
function mqr(U;p=[])
	m,n=size(U);
	r=rank(U);
	if m>=n
		F=qr(U)
		if r<m
			out=MQR(F.Q, F.R, F.Q[:,1:r], F.Q[:,r+1:m])
		else
			out=MQR(F.Q, F.R, F.Q[:,1:r], [])
		end
		return out;
	else 	# m<n
		F=qr(U,Val(true));	# get the independent columns and it's permuation number

		if length(p)==0	
			pnew=sort(F.p[1:m])
		else 	# when the permuation vector is provided
			pleft=setdiff(F.p,p);
			pleft=pleft[1:m-length(p)];
			pnew=vcat(p[:],pleft[:])
		end
		F=qr(U[:,pnew])
		if r<m
			out=MQR(F.Q, (F.Q)'*U, F.Q[:,1:r], F.Q[:,r+1:m])
		else
			out=MQR(F.Q, (F.Q)'*U, F.Q[:,1:r], [])
		end
		return out;
	end
end


"""`Proj=findprojector(U)`
Author: Pilwon Hur, Ph.D.

Input: a matrix U with independent basis column vectors
Output: returns a projector onto the range space of U

the following is a treatment for the case when U contains dependent vectors
"""
function findprojector(U)
	m,=size(U)

	F=mqr(U);
	# r=rank(U);
	# F=qr(U,Val(true));	# get the independent columns and it's permuation number
	# F=qr(U[:,sort(F.p[1:m])[1:r]])
	# V=F.Q[:,1:r]
	V=F.U;
	return V*inv(V'*V)*V';
end