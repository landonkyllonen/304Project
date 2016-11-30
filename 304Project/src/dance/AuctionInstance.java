package dance;
import java.sql.Date;


public class AuctionInstance {
	String seller, winner, name, description, category;
	Date start, end;
	double currentPrice;
	int itemNo, auctionID;
	//image may be a string that is a link to an image for each item?
	
	public AuctionInstance(int auctionID, Date start, Date end, double currentPrice, int itemNo, String seller, String winner, String name, String description, String image, String category){
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
	}
}
