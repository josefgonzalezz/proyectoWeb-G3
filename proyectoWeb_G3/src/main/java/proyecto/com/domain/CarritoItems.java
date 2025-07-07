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
import java.util.List;
import java.time.LocalDateTime;

import lombok.Data;

@Data
@Entity
@Table(name="cart_items")
public class CarritoItems implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="cart_item_id")
    private Long idCartItem;

    @ManyToOne
    @JoinColumn(name="cart_id")
    private Carrito carrito;

    @ManyToMany
    @JoinTable(
        name = "cart_items_productos",       
        joinColumns = @JoinColumn(name = "cart_item_id"),    
        inverseJoinColumns = @JoinColumn(name = "product_id") 
    )
    private List<Producto> productos;

    private int existencias;
    private double precioActual;

    @Column(name="created_at", updatable = false)
    private LocalDateTime agregado;

}
