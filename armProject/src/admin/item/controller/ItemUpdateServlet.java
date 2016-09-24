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
 * Servlet implementation class ItemUpdateServlet
 */
@WebServlet("/aiupdate")
public class ItemUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//상품 수정용 서블릿
		System.out.println("aiupdate 서블릿 구동..");
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
		int itemNo = Integer.parseInt(multi.getParameter("itemno"));
		String itemName = multi.getParameter("itemname");
		int itemCatNo = Integer.parseInt(multi.getParameter("categoryno"));
		int itemPrice = Integer.parseInt(multi.getParameter("itemprice"));
		int itemVender = Integer.parseInt(multi.getParameter("venid"));
		String itemTag = multi.getParameter("itemtag");
		
		//파일이름 제외 객체 생성
		Item item = new Item();
		item.setItemNo(itemNo);
		item.setItemName(itemName);
		item.setItemCatNo(itemCatNo);
		item.setItemPrice(itemPrice);
		item.setItemVender(itemVender);
		item.setItemTag(itemTag);
		
		//수정 전 값 받아오기
		Item oitem = new ItemService().selectOne(itemNo);
		
		ofmini = multi.getFilesystemName("imgmini");
		ofmain = multi.getFilesystemName("img");
		ofdetail = multi.getFilesystemName("imgdetail");
		//여기까지, 원래 이름으로 저장(업로드)된다.
		System.out.println(ofmini+", "+ofmain+", "+ofdetail);//확인용
		//널인지 각각확인해서 널값이면 기존 값 가져와서 넣자!
		
		//출력위한 경로
		String webPath = "/arm/img/item/";

		//img_mini
		if(ofmini != null){
			//기존 파일 지우기
			if(!oitem.getItemImgMini().equals("이미지 없음")){
				String oldfileName = oitem.getItemImgMini().substring(oitem.getItemImgMini().indexOf(webPath)+webPath.length());
				File oldMini = new File(savePath + "\\" + oldfileName);
				oldMini.delete();
			}
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
			item.setItemImgMini(webPath+nfmini);
		}else{
			item.setItemImgMini(oitem.getItemImgMini());
		}
		//img
		if(ofmain != null){
			//기존 파일 지우기
			if(!oitem.getItemImg().equals("이미지 없음")){
				String oldfileName = oitem.getItemImg().substring(oitem.getItemImg().indexOf(webPath)+webPath.length());
				File oldMain = new File(savePath + "\\" + oldfileName);
				oldMain.delete();
			}
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
			item.setItemImg(webPath+nfmain);
		}else{
			item.setItemImg(oitem.getItemImg());
		}
		//img_detail
		if(ofdetail != null){
			//기존 파일 지우기
			if(!oitem.getItemImgDetail().equals("이미지 없음")){
				String oldfileName = oitem.getItemImgDetail().substring(oitem.getItemImgDetail().indexOf(webPath)+webPath.length());
				File oldDetail = new File(savePath + "\\" + oldfileName);
				oldDetail.delete();
			}
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
			item.setItemImgDetail(webPath+nfdetail);
		}else{
			item.setItemImgDetail(oitem.getItemImgDetail());
		}
		
		//update
		int result = new ItemService().updateItem(item);
		
		if(result > 0){
			response.sendRedirect("/arm/ailist");
		}else{
			System.out.println("서블릿 ; 수정 에러..");
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
