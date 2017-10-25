<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>

<petclinic:layout pageName="appointments">
    <h2>Appointments</h2>

    <table id="appointmentsTable" class="table table-striped">
        <thead>
        <tr>
            <th>Pet ID</th>
            <th>Appointment Date</th>
	    <th>Description </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${appointments.appointmentList}" var="appointment">
            <tr>
                <td>
                    <c:out value="${appointment.petid}"/>
                </td>
                <td>
                    <c:out value="${appointment.appointmentdate}"/>
                </td>
                <td>
                    <c:out value="${appointment.description}"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <table class="table-buttons">
        <tr>
            <td>
                <a href="<spring:url value="/appointments.xml" htmlEscape="true" />">View as XML</a>
            </td>
            <td>
                <a href="<spring:url value="/appointments.json" htmlEscape="true" />">View as JSON</a>
            </td>
        </tr>
    </table>
</petclinic:layout>
