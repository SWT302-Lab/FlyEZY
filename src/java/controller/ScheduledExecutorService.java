/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.OrderDAO;
import dal.TicketDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import jakarta.servlet.annotation.WebListener;
import model.Ticket;

/**
 *
 * @author Admin
 */
@WebListener
public class ScheduledExecutorService implements ServletContextListener {

    private java.util.concurrent.ScheduledExecutorService scheduler;
    private TicketDAO td = new TicketDAO();
    private OrderDAO od = new OrderDAO();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newScheduledThreadPool(1);
        Runnable task = () -> {
            System.out.println("Hello 1");
            List<Integer> alertOverdue = td.getTicketsBeforeOverdue();
            for (Integer id : alertOverdue) {
                String email = od.getOrderById(td.getTicketById(id).getOrder_id()).getContactEmail();
                System.out.println("Gửi mail");
            }
            System.out.println("Hello 2");
            List<Integer> overdueTicket = td.getOverdueTicket();
            for (Integer id : overdueTicket) {
                System.out.println(id);
                td.cancelTicketById(id);
                Ticket t = td.getTicketById(id);
                if(td.countNumberTicketNotCancel(t.getOrder_id())<=0){
                    od.cancelOrderById(t.getOrder_id());
                }
            }
        };
        scheduler.scheduleAtFixedRate(task, 0, 10, TimeUnit.SECONDS);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdown();
            try {
                if (!scheduler.awaitTermination(5, TimeUnit.SECONDS)) {
                    scheduler.shutdownNow();
                }
            } catch (InterruptedException e) {
                scheduler.shutdownNow();
            }
        }
    }
}
