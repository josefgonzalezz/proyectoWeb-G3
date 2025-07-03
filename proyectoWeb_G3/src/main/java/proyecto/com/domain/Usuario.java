/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package proyecto.com.domain;

/**
 *
 * @author XPC
 */
import java.io.Serializable;

import jakarta.persistence.*; 
import lombok.Data;

@Data
@Entity
@Table(name = "users")
public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long idProducto;

    private String username;
    private String email;
    private String password_hash;
    private String first_name;
    private String last_name;
    private String phone;

    @Enumerated(EnumType.STRING)
    private Role role;

    private boolean activo;

    @OneToOne
    @JoinColumn(name = "user_id")
    private Usuario usuario;

    public Usuario() {
    }
}
