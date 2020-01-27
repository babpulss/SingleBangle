package recoder.single.bangle.account.service;

import java.io.FileInputStream;
import java.io.StringReader;
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
			
			fontProvider.register(rootPath+"\\font\\MalgunGothic.TTF","MalgunGothic");
			CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);
			HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
			htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
			
			
			PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
			HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
			CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);
			
			XMLWorker worker = new XMLWorker(css, true);
			XMLParser xmlParser = new XMLParser(worker,Charset.forName("UTF-8"));
			
			
			String htmlStr = "<html><head></head><body style='font-family:MalgunGothic;'>"+pdfValue+"</body></html>";
//			System.out.println(htmlStr);
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
