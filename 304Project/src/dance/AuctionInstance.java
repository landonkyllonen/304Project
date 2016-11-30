package dance;


public class AuctionInstance {
	String seller, winner, name, description, category, image;
	String start, end;
	String currentPrice;
	String itemNo, auctionID;
	//image may be a string that is a link to an image for each item?
	
	public AuctionInstance(String auctionID, String start, String end, String currentPrice, String itemNo, String seller, String winner, String name, String description, String image, String category){
		this.itemNo=itemNo;
		this.name=name;
		this.description=description;
		this.category=category;
		this.seller=seller;
		this.end=end;
		this.currentPrice=currentPrice;
		this.winner=winner;
		this.auctionID=auctionID;
		this.start=start;
		this.image=image;
	}
	
	public String getAuctionID(){
		return this.auctionID;
	}
	public String getItemNo(){
		return this.auctionID;
	}
	public String getPrice(){
		return this.currentPrice;
	}
	public String getStart(){
		return this.start;
	}
	public String getEnd(){
		return this.end;
	}
	public String getSeller(){
		return this.seller;
	}
	public String getWinner(){
		return this.winner;
	}
	public String getName(){
		return this.name;
	}
	public String getDesc(){
		return this.description;
	}
	public String getCategory(){
		return this.category;
	}
	public String getImage(){
		return this.image;
	}
}
