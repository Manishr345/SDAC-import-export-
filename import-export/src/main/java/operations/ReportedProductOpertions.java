package operations;

import java.util.List;

import models.ReportedProducts;
import models.SellerPort;

public interface ReportedProductOpertions {
	void changeStatus(ReportedProducts products) throws Exception;
	List<ReportedProducts> showReportedProducts(String id) throws Exception;
}
