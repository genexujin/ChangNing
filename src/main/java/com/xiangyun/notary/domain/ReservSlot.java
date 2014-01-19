package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "reservation_slots")
@NamedQueries({
    @NamedQuery(name="ReservSlot.findAll", query="select o from ReservSlot o")
})
public class ReservSlot {
	 	@Id
	    @GeneratedValue(strategy = IDENTITY)
	    private Long id;
	 	
	 	@Column(name = "tag")
	    private String tag;
	    
	    @Column(name = "am")
	    private String am;

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public String getTag() {
			return tag;
		}

		public void setTag(String tag) {
			this.tag = tag;
		}

		public String getAm() {
			return am;
		}

		public void setAm(String am) {
			this.am = am;
		}

		
	 
	  
}
