/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package proyecto.com.domain;

/**
 *
 * @author Andres
 */
import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

import lombok.Data;

@Data
@Entity
@Table(name = "cart")  
public class Carrito implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="cart_id")
    private Long idCart;

    @OneToOne
    @JoinColumn(name="user_id", nullable = false)
    private Usuario usuario;

    @Column(name="created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Carrito() {
    }
}


