package com.xiangyun.notary.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.xiangyun.notary.common.CertificatePurpose;
import com.xiangyun.notary.common.CredentialType;
import com.xiangyun.notary.common.DestinationCountry;
import com.xiangyun.notary.common.Gender;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.domain.User;
import com.xiangyun.notary.service.UserService;

@Controller
public class UserController {

    private static Logger log = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/createUser.do")
    public ModelAndView createUser() {
        
        Order o = new Order();
        o.setCertificateCopyCount(2);
        o.setCertificatePurpose(CertificatePurpose.RESIDENCE);
        o.setDestination(DestinationCountry.GERMANY);
        o.setNeedTranslation(true);
        o.setOrderDate(new Date());
        o.setOrderStatus(OrderStatus.SUBMITTED);
        o.setPaymentPaid(0);
        o.setPaymentStatus(OrderPaymentStatus.NOT_PAID);
        o.setPaymentTotal(240);
        o.setVisitForDoc(false);
        
        User u = new User();
        u.setAddress("adresssss");
        u.setBirthDate(new Date());
        u.setCredentialType(CredentialType.ID_CARD);
        u.setEmail("pairliu@gmail.com");
        u.setMobile("1351111111");
        u.setName("刘峻");
        u.setPassword("abcd1234");
        u.setCredentialId("132412341");
        u.setGender(Gender.MALE);
        //The relation is managed in this method for both ends.
        u.addOrder(o);

        //This will also create the new Order entry, as CascadeType.PERSIST is set on the relationship.
        u = userService.save(u);

        ModelAndView mav = new ModelAndView("user");
        mav.addObject("user", u);

        return mav;
    }

}
