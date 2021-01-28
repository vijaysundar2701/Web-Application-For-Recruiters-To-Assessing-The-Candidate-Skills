
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Out;
import org.apache.poi.util.SystemOutLogger;

import com.mysql.jdbc.Statement;

/**
 * Servlet implementation class generate
 */
@WebServlet("/generate")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class generate extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String connectionURL = "jdbc:mysql://localhost:3306/ielts";
		String user = "root";
		String pass = "root";
		response.setContentType("text/html");
		String[] a = request.getParameterValues("catagery");
		String sc = request.getParameter("score");
		float score = Float.parseFloat(sc);
		String selStmt = "";
		String tabName = "";
		String cond = "";
		List list = new ArrayList();
		Map map = null;
		String filter = null;
		StringBuilder query = new StringBuilder();
		boolean flag = false;
		for (int i = 0; i < a.length; i++) {
			if(flag==true) {
				query.append(" UNION ");
			}
			selStmt = "select distinct CName,Application_id,Score from ";
			query.append(selStmt);
			tabName = a[i].toLowerCase()+" ";
			query.append(tabName);
			cond = "where Score="+sc;
			query.append(cond);
			flag =true;
		}
		Connection con = null;
		HttpSession ses = request.getSession();
		System.out.println("Query>>"+query);
		try {

			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(connectionURL, user, pass);
			Statement st = (Statement) con.createStatement();
			ResultSet rs = st.executeQuery(query.toString());
			while (rs.next()) {
				
							map = new HashMap<>();
							map.put("Cname", rs.getString("Cname"));
							map.put("Application_id", rs.getString("Application_id"));
							map.put("Score", rs.getString("Score"));
							list.add(map);
				
			}
			System.out.println(list);
			ses.setAttribute("list", list);
			response.sendRedirect("viewresult.jsp");
		} catch (Exception i) {
			i.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (Exception i) {
					i.printStackTrace();
				}
			}

		}
	}

}
