package recoder.single.bangle.account.service;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

@Service
public class PdfService {

	public void createPdf(HttpServletRequest req,HttpServletResponse resp,String pdfValue){
		
		
//	     URL oracle = new URL("http://localhost/");
//	      BufferedReader in = new BufferedReader(
//	            new InputStreamReader(oracle.openStream()));
//
//	      String inputLine;
//	      while ((inputLine = in.readLine()) != null)
//	         System.out.println(inputLine);
//	      in.close();
	   
		System.out.println("도착");
		Document document = new Document(PageSize.A4, 50, 50, 50,50);
		PdfWriter writer;
		
		
		try {
			writer = PdfWriter.getInstance(document, resp.getOutputStream());
			writer.setInitialLeading(12.5f);
			resp.setContentType("application/pdf");
			String fileName = URLEncoder.encode("가계부","UTF-8");
			resp.setHeader("Content-Transper-Encoding", "binary");
			resp.setHeader("Content-Disposition", "inline;filename="+fileName+".pdf");
			document.open();
			
			CSSResolver cssResolver = new StyleAttrCSSResolver();
			String rootPath = req.getServletContext().getRealPath("/resources");
			CssFile cssFile = XMLWorkerHelper.getCSS(new FileInputStream(rootPath + "/css/accountCSS/detailAccountCSS.css"));
			cssResolver.addCss(cssFile);
			XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
			fontProvider.register("D:\\singlebangle\\SingleWorkspace\\SingleBangle\\src\\main\\webapp\\resources\\font\\MalgunGothic.TTF","MalgunGothic");
			CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);
			HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
			htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
			
//			Image image1 = Image.getInstance("//파일//경로//입력");
//
//			image1.scaleToFit(1200, 800);
//
//			image1.setAbsolutePosition(10, 60);
//
//		
//
//			Image image2 = Image.getInstance("//파일//경로//입력");
//
//			image2.scaleToFit(50,50);
//
//			image2.setAbsolutePosition(400, 200);
//
//			document.add(image1);
//
//			document.add(image2);
			
			PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
			HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
			CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);
			//System.out.println(pdfValue);
			XMLWorker worker = new XMLWorker(css, true);
			XMLParser xmlParser = new XMLParser(worker,Charset.forName("UTF-8"));
			
			
			String htmlStr = "<html><head></head><body style='font-family:MalgunGothic;'>"+pdfValue+"</body></html>";
			System.out.println(htmlStr);
			StringReader strReader = new StringReader(htmlStr);
			xmlParser.parse(strReader);
			document.close();
			writer.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
