Cb_rec = class("Cb_rec")

function Cb_rec:ctor()
	self:init()
end
function Cb_rec:init()
	--创建一个数组储存棋盘信息
	self.cb_save={}
	self.turn=0
	self.win=0
	self.ai_x,self.ai_y=0,0
	for i=1,16 do
		self.cb_save[i]={}
		for j=1,16 do
			self.cb_save[i][j]=0
		end
	end
	self:show()
end

--显示数组棋盘
function Cb_rec:show()
	local s=""
	for i=16,1,-1 do
		for j=1,16 do
			s=string.format(s..self.cb_save[j][i].." ")
		end
		print(s)
		s=""
	end
	print()
end
--将范围坐标转化为固定坐标
function Cb_rec:adjpos(x,y)
	--点击坐标
	local x,y=x,y
	--中心坐标
	local fx,fy = 384.5,384.5
	--偏移坐标为8
	local fp = 8
	for i=1,16 do
		for j=1,16 do
			if (((x<=fx+32*(i-8)+fp)and(x>=fx+32*(i-8)-fp))and((y<=fx+32*(j-8)+fp)and(y>=fx+32*(j-8)-fp))) then
				return fx+32*(i-8),fy+32*(j-8)
			end
		end
	end
	return 0,0
end
--将数组转化为固定坐标
function Cb_rec:numtopos(x,y)
	--数组坐标
	local x,y=x,y
	--中心坐标
	local fx,fy = 384.5,384.5
	for i=1,16 do
		for j=1,16 do
			if (x== i and y==j) then
				return (fx+32*(i-8)),(fy+32*(j-8))
			end
		end
	end
	return 0,0
end
--将坐标转化为数组
function Cb_rec:transtopos(cb_cx,cb_cy)
	local cb_cx,cb_cy = cb_cx,cb_cy
	local fx,fy = 384.5,384.5
	for i=1,16 do
		for j=1,16 do
			if ((cb_cx==fx+32*(i-8))and(cb_cy==fy+32*(j-8))) then
				return i,j
			end
		end
	end
	return -1,-1
end
--记录棋子
function Cb_rec:record(ccx,ccy,type)
	local ccx,ccy=ccx,ccy
	local type = type
	if (type==1)then
		self.cb_save[ccx][ccy]=1
	elseif(type==2)then
		self.cb_save[ccx][ccy]=2
	end

	
end
--判断该点是否有子
function Cb_rec:enable(x,y)
	local x,y=x,y
	if (self.cb_save[x][y]~=0) then
		return false
	else
		return true
	end
	
end
--棋局胜利判断
function Cb_rec:winchk()
	--横
	for i=1,12 do
		for j=1,16 do
			if ((self.cb_save[i][j]==2)and(self.cb_save[i+1][j]==2)and(self.cb_save[i+2][j]==2)and(self.cb_save[i+3][j]==2)and(self.cb_save[i+4][j]==2)) then
				self.win=2
			elseif ((self.cb_save[i][j]==1)and(self.cb_save[i+1][j]==1)and(self.cb_save[i+2][j]==1)and(self.cb_save[i+3][j]==1)and(self.cb_save[i+4][j]==1)) then
				self.win=1
			end
		end
	end
	--竖
	for i=1,16 do
		for j=1,12 do
			if ((self.cb_save[i][j]==2)and(self.cb_save[i][j+1]==2)and(self.cb_save[i][j+2]==2)and(self.cb_save[i][j+3]==2)and(self.cb_save[i][j+4]==2)) then
				self.win=2
			elseif ((self.cb_save[i][j]==1)and(self.cb_save[i][j+1]==1)and(self.cb_save[i][j+2]==1)and(self.cb_save[i][j+3]==1)and(self.cb_save[i][j+4]==1)) then
				self.win=1
			end
		end
	end
	--斜
	for i=1,12 do
		for j=1,12 do
			if ((self.cb_save[i][j]==2)and(self.cb_save[i+1][j+1]==2)and(self.cb_save[i+2][j+2]==2)and(self.cb_save[i+3][j+3]==2)and(self.cb_save[i+4][j+4]==2)) then
				self.win=2
			elseif ((self.cb_save[i][j]==1)and(self.cb_save[i+1][j+1]==1)and(self.cb_save[i+2][j+2]==1)and(self.cb_save[i+3][j+3]==1)and(self.cb_save[i+4][j+4]==1)) then
				self.win=1
			elseif ((self.cb_save[i+4][j]==2)and(self.cb_save[i+3][j+1]==2)and(self.cb_save[i+2][j+2]==2)and(self.cb_save[i+1][j+3]==2)and(self.cb_save[i][j+4]==2)) then
				self.win=2
			elseif ((self.cb_save[i][j+4]==1)and(self.cb_save[i+1][j+3]==1)and(self.cb_save[i+2][j+2]==1)and(self.cb_save[i+3][j+1]==1)and(self.cb_save[i+4][j]==1)) then
				self.win=1
			end
		end
	end
end
function Cb_rec:simple_ai()


	--		单子检测
	for i=1,16 do
		for j=1,16 do
			if ((self.cb_save[i][j]==2)or(self.cb_save[i][j]==1)) then
				if (cb_rec:enable(i+1,j)==true and i<=15) then
					self.ai_x,self.ai_y=i+1,j
				end
				if(cb_rec:enable(i-1,j)==true and i>=2)then
					self.ai_x,self.ai_y=i-1,j
				end
				if (cb_rec:enable(i+1,j+1)==true and j<=15 and i<=15) then
					self.ai_x,self.ai_y=i+1,j+1
				end
				if(cb_rec:enable(i-1,j+1)==true and j<=15 and i>=2)then
					self.ai_x,self.ai_y=i-1,j+1
				end
				if (cb_rec:enable(i+1,j-1)==true and j>=2 and i<=15) then
					self.ai_x,self.ai_y=i+1,j-1
				end
				if(cb_rec:enable(i-1,j-1)==true and j>=2 and i>=2)then
					self.ai_x,self.ai_y=i-1,j-1
				end
				if (cb_rec:enable(i,j+1)==true and j<=15) then
					self.ai_x,self.ai_y=i,j+1
				end
				if(cb_rec:enable(i,j-1)==true and j>=2)then
					self.ai_x,self.ai_y=i,j-1
				end
			end
		end
	end
		--		横:2子检测
	for i=1,15 do
		for j=1,16 do
			if ((self.cb_save[i][j]==2)and(self.cb_save[i+1][j]==2)) then
				if (cb_rec:enable(i+2,j)==true and i<=13) then
					self.ai_x,self.ai_y=i+2,j
				end
				if(cb_rec:enable(i-1,j)==true and i>=2)then
					self.ai_x,self.ai_y=i-1,j
				end
			elseif ((self.cb_save[i][j]==1)and(self.cb_save[i+1][j]==1)) then
				if (cb_rec:enable(i+2,j)==true and i<=13) then
					self.ai_x,self.ai_y=i+2,j
				end
				if(cb_rec:enable(i-1,j)==true and i>=2)then
					self.ai_x,self.ai_y=i-1,j
				end
			end
		end
	end
	--		竖:2子检测
	for i=1,16 do
		for j=1,15 do
			if ((self.cb_save[i][j]==2)and(self.cb_save[i][j+1]==2)) then
				if (cb_rec:enable(i,j+2)==true and i<=13) then
					self.ai_x,self.ai_y=i,j+2
				end
				if(cb_rec:enable(i,j-1)==true and i>=2)then
					self.ai_x,self.ai_y=i,j-1
				end
			elseif ((self.cb_save[i][j]==1)and(self.cb_save[i][j+1]==1)) then
				if (cb_rec:enable(i,j+2)==true and i<=13) then
					self.ai_x,self.ai_y=i,j+2
				end
				if(cb_rec:enable(i,j-1)==true and i>=2)then
					self.ai_x,self.ai_y=i,j-1
				end
			end
		end
	end
	--		斜:2子检测
	for i=1,15 do
		for j=1,15 do
			if ((self.cb_save[i][j]==2)and(self.cb_save[i+1][j+1]==2)) then
				if (cb_rec:enable(i+2,j+2)==true and j<=13 and i<=13) then
					self.ai_x,self.ai_y=i+2,j+2
				end
				if(cb_rec:enable(i-1,j-1)==true and j>=2 and i>=2)then
					self.ai_x,self.ai_y=i-1,j-1
				end
			elseif ((self.cb_save[i][j]==1)and(self.cb_save[i+1][j+1]==1)) then
				if (cb_rec:enable(i+2,j+2)==true and j<=13 and i<=13) then
					self.ai_x,self.ai_y=i+2,j+2
				end
				if(cb_rec:enable(i-1,j-1)==true and j>=2 and i>=2)then
					self.ai_x,self.ai_y=i-1,j-1
				end
			elseif ((self.cb_save[i][j+1]==2)and(self.cb_save[i+1][j]==2)) then
				if (cb_rec:enable(i+2,j-1)==true and j<=13 and i<=13) then
					self.ai_x,self.ai_y=i+2,j-1
				end
				if(cb_rec:enable(i-1,j+2)==true and j>=2 and i>=2)then
					self.ai_x,self.ai_y=i-1,j+2
				end
			elseif ((self.cb_save[i][j+1]==1)and(self.cb_save[i+1][j]==1)) then
				if (cb_rec:enable(i+2,j-1)==true and j<=13 and i<=13) then
					self.ai_x,self.ai_y=i+2,j-1
				end
				if(cb_rec:enable(i-1,j+2)==true and j>=2 and i>=2)then
					self.ai_x,self.ai_y=i-1,j+2
				end
			end
		end
	end
	---[[
	--		横:3子检测
	for i=1,14 do
		for j=1,16 do
			if ((self.cb_save[i][j]==2)and(self.cb_save[i+1][j]==2)and(self.cb_save[i+2][j]==2)) then
				if (cb_rec:enable(i+3,j)==true and i<=11) then
					self.ai_x,self.ai_y=i+3,j
				elseif(cb_rec:enable(i-1,j)==true and i>=2)then
					self.ai_x,self.ai_y=i-1,j
				end
			elseif ((self.cb_save[i][j]==1)and(self.cb_save[i+1][j]==1)and(self.cb_save[i+2][j]==1)) then
				if (cb_rec:enable(i+3,j)==true and i<=11) then
					self.ai_x,self.ai_y=i+3,j
				elseif(cb_rec:enable(i-1,j)==true and i>=2)then
					self.ai_x,self.ai_y=i-1,j
				end
			end
		end
	end
	--		竖:3子检测
	for i=1,16 do
		for j=1,14 do
			if ((self.cb_save[i][j]==2)and(self.cb_save[i][j+1]==2)and(self.cb_save[i][j+2]==2)) then
				if (cb_rec:enable(i,j+3)==true and j<=11) then
					self.ai_x,self.ai_y=i,j+3
				elseif(cb_rec:enable(i,j-1)==true and j>=2)then
					self.ai_x,self.ai_y=i,j-1
				end
			elseif ((self.cb_save[i][j]==1)and(self.cb_save[i][j+1]==1)and(self.cb_save[i][j+2]==1)) then
				if (cb_rec:enable(i,j+3)==true and j<=11) then
					self.ai_x,self.ai_y=i,j+3
				elseif(cb_rec:enable(i,j-1)==true and j>=2)then
					self.ai_x,self.ai_y=i,j-1
				end
			end
		end
	end
	--		斜:3子检测
	for i=1,14 do
		for j=1,14 do
			if ((self.cb_save[i][j]==2)and(self.cb_save[i+1][j+1]==2)and(self.cb_save[i+2][j+2]==2)) then
				if (cb_rec:enable(i+3,j+3)==true and j<=11 and i<=11) then
					self.ai_x,self.ai_y=i+3,j+3
				elseif(cb_rec:enable(i-1,j-1)==true and j>=2 and i>=2)then
					self.ai_x,self.ai_y=i-1,j-1
				end
			elseif ((self.cb_save[i][j]==1)and(self.cb_save[i+1][j+1]==1)and(self.cb_save[i+2][j+2]==1)) then
				if (cb_rec:enable(i+3,j+3)==true and j<=11 and i<=11) then
					self.ai_x,self.ai_y=i+3,j+3
				elseif(cb_rec:enable(i-1,j-1)==true and j>=2 and i>=2)then
					self.ai_x,self.ai_y=i-1,j-1
				end
			elseif ((self.cb_save[i+2][j]==2)and(self.cb_save[i+1][j+1]==2)and(self.cb_save[i][j+2]==2)) then
				if (cb_rec:enable(i+3,j-1)==true and j<=11 and i<=11) then
					self.ai_x,self.ai_y=i+3,j-1
				elseif(cb_rec:enable(i-1,j+3)==true and j>=2 and i>=2)then
					self.ai_x,self.ai_y=i-1,j+3
				end
			elseif ((self.cb_save[i+2][j]==1)and(self.cb_save[i+1][j+1]==1)and(self.cb_save[i][j+2]==1)) then
				if (cb_rec:enable(i+3,j-1)==true and j<=9 and i<=9) then
					self.ai_x,self.ai_y=i+3,j-1
				elseif(cb_rec:enable(i-1,j+3)==true and j>=2 and i>=2)then
					self.ai_x,self.ai_y=i-1,j+3
				end
			end
		end
	end
	--]]
	if(self.ai_x~=0 and self.ai_y~=0)then
		return self.ai_x,self.ai_y
	end
	
end
