package com.rays.pro4.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rays.pro4.Bean.BaseBean;
import com.rays.pro4.Bean.OrderBean;
import com.rays.pro4.Exception.ApplicationException;
import com.rays.pro4.Exception.DuplicateRecordException;
import com.rays.pro4.Model.CollegeModel;
import com.rays.pro4.Model.CustomerModel;
import com.rays.pro4.Model.OrderModel;
import com.rays.pro4.Util.DataUtility;
import com.rays.pro4.Util.DataValidator;
import com.rays.pro4.Util.PropertyReader;
import com.rays.pro4.Util.ServletUtility;

@WebServlet(name = "OrderCtl", urlPatterns = { "/ctl/OrderCtl" })
public class OrderCtl extends BaseCtl {

	@Override
	protected boolean validate(HttpServletRequest request) {

		boolean pass = true;

		if (DataValidator.isNull(request.getParameter("customerName"))) {
			request.setAttribute("customerName", PropertyReader.getValue("error.require", "Customer Name"));
			pass = false;
		}

		if (DataValidator.isNull(request.getParameter("orderDate"))) {
			request.setAttribute("orderDate", PropertyReader.getValue("error.require", "Order Date "));
			pass = false;
		}
		if (DataValidator.isNull(request.getParameter("totalAmount"))) {
			request.setAttribute("totalAmount", PropertyReader.getValue("error.require", "Total Amount "));
			pass = false;
		}

		return pass;
	}

	@Override
	protected void preload(HttpServletRequest request) {
		 CustomerModel model = new CustomerModel();
	        try {
	            List list = model.list();
	            request.setAttribute("customerList", list);
	        } catch (ApplicationException e) {
	        } catch (Exception e) {


				e.printStackTrace();
			}

	}
	
	
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		OrderBean bean = new OrderBean();

		System.out.println("requesttttidddddd=>" + request.getParameter("id"));
		bean.setId(DataUtility.getLong(request.getParameter("id")));
		System.out.println("beannnnnnnnniddddddd=>" + bean.getId());

		System.out.println("requesttttidddddd=>" + request.getParameter("customerId"));
		bean.setCustomerId(DataUtility.getLong(request.getParameter("customerId")));
		System.out.println("beannnnnnnnniddddddd=>" + bean.getCustomerId());

		System.out.println("requesttttcusssss=>" + request.getParameter("customerName"));
		bean.setCustomerName(DataUtility.getString(request.getParameter("customerName")));
		System.out.println("beannnnnnnnnncussssss=>" + bean.getCustomerName());

		System.out.println("date simple => " + request.getParameter("orderDate"));
		bean.setOrderDate(DataUtility.getDate(request.getParameter("orderDate")));
		System.out.println("date => " + bean.getOrderDate());

		System.out.println("reqestrtttt expppppppppp=>" + request.getParameter("totalAmount"));
		bean.setTotalAmount(DataUtility.getLong(request.getParameter("totalAmount")));
		System.out.println("beannnnnnnnnnExpppppp" + bean.getTotalAmount());

		populateDTO(bean, request);
		return bean;
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("in do post method");

		String op = DataUtility.getString(request.getParameter("operation"));

		OrderModel model = new OrderModel();

		OrderBean bean = (OrderBean) populateBean(request);

		if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {
			try {

				if (bean.getId() != 0 && bean.getId() > 0) {
					model.update(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("Order updated Successfully..!!", request);
					ServletUtility.forward(getView(), request, response);
				} else {
					model.add(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("Order Added Successfully..!!", request);
					ServletUtility.forward(getView(), request, response);
				}

			} catch (DuplicateRecordException e) {
				ServletUtility.setBean(bean, request);
				ServletUtility.setErrorMessage("Name  already exist", request);
				ServletUtility.forward(getView(), request, response);
			} catch (ApplicationException e) {
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (OP_RESET.equalsIgnoreCase(op)) {
			ServletUtility.redirect(ORSView.ORDER_CTL, request, response);
			return;
		}

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("in do get method");
		String op = DataUtility.getString(request.getParameter("operation"));
		Long id = DataUtility.getLong(request.getParameter("id"));

		if (id > 0) {

			OrderModel model = new OrderModel();

			try {
				OrderBean bean = model.findByPk(id);
				ServletUtility.setBean(bean, request);
			} catch (ApplicationException e) {
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		ServletUtility.forward(getView(), request, response);
	}

	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return ORSView.ORDER_VIEW;
	}

}
