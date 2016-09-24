package admin.item.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.item.model.service.ItemService;
import admin.item.model.vo.Item;

/**
 * Servlet implementation class ItemInsertServlet
 */
@WebServlet("/aiinsert")
public class ItemInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//상품추가 서블릿
		System.out.println("aiinsert 서블릿 구동..");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		//최대 파일 크기
		int sizeLimit = 1024*1024*100;
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(!isMultipart){
			System.out.println("multipart가 아님....");
		}
		//저장위치 (웹컨테이너 내) > 구동안될시 절대경로로 쓰자!
		String savePath = request.getSession().getServletContext().getRealPath("/img/item/");
		System.out.println("저장경로 : " + savePath);

		//업로드할 파일원래이름, 저장할 이름
		String ofmini = null;
		String nfmini = null;
		String ofmain = null;
		String nfmain = null;
		String ofdetail = null;
		String nfdetail = null;
		
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		//전달받은 값
		String itemName = multi.getParameter("itemname");
		int itemCatNo = Integer.parseInt(multi.getParameter("categoryno"));
		int itemPrice = Integer.parseInt(multi.getParameter("itemprice"));
		int itemVender = Integer.parseInt(multi.getParameter("venid"));
		String itemTag = multi.getParameter("itemtag");
		
		//파일이름 제외 객체 생성후, 먼저 insert
		Item item = new Item(itemName, itemCatNo, itemPrice, itemVender, itemTag);
		int result = new ItemService().insertItem(item);
		
	
		if(result > 0){ //insert 성공시
			System.out.println("1차 insert 성공...");
			
			ofmini = multi.getFilesystemName("imgmini");
			ofmain = multi.getFilesystemName("img");
			ofdetail = multi.getFilesystemName("imgdetail");
			//여기까지, 원래 이름으로 저장(업로드)된다.
			System.out.println(ofmini+", "+ofmain+", "+ofdetail);//확인용
			
			//바꿀 파일이름 >itemNo를 이용한다.
			int itemNo = new ItemService().getItemNo(item);
			System.out.println(itemNo);

			//출력위한 경로
			String webPath = "/arm/img/item/";
			//변경된 파일이름 객체에 담는다.
			Item fitem = new Item();
			fitem.setItemNo(itemNo);

			//img_mini
			if(ofmini != null){
				//저장된 파일명바꾸기
				nfmini = itemNo+"_mini."+ofmini.substring(ofmini.indexOf(".")+1);
				File saveMini= new File(savePath + "\\" + ofmini);
				File newMini = new File(savePath +"\\" + nfmini);
				
				//파일명 바꾸고, 실패시 강제 변환.
				if(!saveMini.renameTo(newMini)){
					//파일 읽기용 변수
					int read = 0;
					
					byte[] buf = new byte[1024];
					
					//파일 입력용 스트림
					FileInputStream fin = new FileInputStream(saveMini);
					FileOutputStream fout = new FileOutputStream(newMini);
					
					while((read = fin.read(buf, 0, buf.length)) != -1){
						fout.write(buf);
					}
					fin.close();
					fout.close();
					saveMini.delete();//원본삭제				
				}
				fitem.setItemImgMini(webPath+nfmini);
			}else{
				fitem.setItemImgMini("이미지 없음");
			}
			//img
			if(ofmain != null){
				//저장된 파일명바꾸기
				nfmain = itemNo+"."+ofmain.substring(ofmain.indexOf(".")+1);
				File saveMain= new File(savePath + "\\" + ofmain);
				File newMain = new File(savePath +"\\" + nfmain);
				
				//파일명 바꾸고, 실패시 강제 변환.
				if(!saveMain.renameTo(newMain)){
					//파일 읽기용 변수
					int read = 0;
					
					byte[] buf = new byte[1024];
					
					//파일 입력용 스트림
					FileInputStream fin = new FileInputStream(saveMain);
					FileOutputStream fout = new FileOutputStream(newMain);
					
					while((read = fin.read(buf, 0, buf.length)) != -1){
						fout.write(buf);
					}
					fin.close();
					fout.close();
					saveMain.delete();//원본삭제				
				}
				fitem.setItemImg(webPath+nfmain);
			}else{
				fitem.setItemImg("이미지 없음");
			}
			
			//img_detail
			if(ofdetail != null){
				//저장된 파일명바꾸기
				nfdetail = itemNo+"_detail."+ofdetail.substring(ofdetail.indexOf(".")+1);
				File saveDetail= new File(savePath + "\\" + ofdetail);
				File newDetail = new File(savePath +"\\" + nfdetail);
				
				//파일명 바꾸고, 실패시 강제 변환.
				if(!saveDetail.renameTo(newDetail)){
					//파일 읽기용 변수
					int read = 0;
					
					byte[] buf = new byte[1024];
					
					//파일 입력용 스트림
					FileInputStream fin = new FileInputStream(saveDetail);
					FileOutputStream fout = new FileOutputStream(newDetail);
					
					while((read = fin.read(buf, 0, buf.length)) != -1){
						fout.write(buf);
					}
					fin.close();
					fout.close();
					saveDetail.delete();//원본삭제				
				}
				fitem.setItemImgDetail(webPath+nfdetail);
			}else{
				fitem.setItemImgDetail("이미지 없음");
			}

			
			int fresult = new ItemService().updateFileName(fitem);
			
			if(fresult > 0){
				response.sendRedirect("/arm/ItemViewServlet");
			}else{
				System.out.println("2차 update 실패..");
			}
		}else{
			//insert실패시
			System.out.println("1차 insert 실패..");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
