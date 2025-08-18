/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package proyecto.com.service.impl;

import proyecto.com.dao.FacturaDao;
import proyecto.com.dao.VentaDao;
import proyecto.com.domain.Usuario;
import proyecto.com.domain.Factura;
import proyecto.com.domain.Item;
import proyecto.com.domain.Venta;
import proyecto.com.service.ItemService;
import java.util.List;
import java.util.Objects;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import proyecto.com.dao.ProductoDao;
import proyecto.com.dao.UsuarioDao;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

@Service
public class ItemServiceImpl implements ItemService {

    @Autowired
    private HttpSession session;
    
    // Obtiene la lista de ítems desde la sesión, inicializándola si es necesario
    private List<Item> getItemsFromSession() {
        @SuppressWarnings("unchecked")
        List<Item> listaItems = (List<Item>) session.getAttribute("listaItems");
        if (listaItems == null) {
            listaItems = new ArrayList<>();
            session.setAttribute("listaItems", listaItems);
        }
        return listaItems;
    }

    @Override
    public List<Item> gets() {
        return getItemsFromSession();
    }

    @Override
    public Item get(Item item) {
        List<Item> listaItems = getItemsFromSession();
        for (Item i : listaItems) {
            if (Objects.equals(i.getIdProducto(), item.getIdProducto())) {
                return i;
            }
        }
        return null;
    }

    // Método para agregar la cantidad al ítem en la sesión (si existe suma, si no agrega nuevo)
    @Override
    public void add(Item item, int cantidad) {
        List<Item> listaItems = getItemsFromSession();
        Item itemExistente = get(item);
        
        if (itemExistente == null) {
            item.setCantidad(cantidad);
            listaItems.add(item);
        } else {
            int nuevaCantidad = itemExistente.getCantidad() + cantidad;
            if (nuevaCantidad > itemExistente.getExistencias()) {
                nuevaCantidad = itemExistente.getExistencias();
            }
            itemExistente.setCantidad(nuevaCantidad);
        }
        session.setAttribute("listaItems", listaItems);
    }
    
    // save usa add para evitar duplicar lógica
    @Override
    public void save(Item item) {
        add(item, item.getCantidad());
    }

    @Override
    public void delete(Item item) {
        List<Item> listaItems = getItemsFromSession();
        listaItems.removeIf(i -> Objects.equals(i.getIdProducto(), item.getIdProducto()));
        session.setAttribute("listaItems", listaItems);
    }

    @Override
    public void update(Item item) {
        List<Item> listaItems = getItemsFromSession();
        for (var i : listaItems) {
            if (Objects.equals(i.getIdProducto(), item.getIdProducto())) {
                i.setCantidad(item.getCantidad());
                break;
            }
        }
        session.setAttribute("listaItems", listaItems);
    }

    @Autowired
    private UsuarioDao usuarioDao;
    @Autowired
    private ProductoDao productoDao;
    @Autowired
    private FacturaDao facturaDao;
    @Autowired
    private VentaDao ventaDao;

    @Override
    public void facturar() {
        String username = "";
        var principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (principal instanceof UserDetails userDetails) {
            username = userDetails.getUsername();
        } else if (principal != null) {
            username = principal.toString();
        }

        if (username.isBlank()) {
            System.out.println("username en blanco...");
            return;
        }

        Usuario usuario = usuarioDao.findByUsername(username);
        if (usuario == null) {
            System.out.println("Usuario no existe en usuarios...");
            return;
        }

        Factura factura = new Factura(usuario.getIdUsuario());
        factura = facturaDao.save(factura);

        List<Item> listaItems = getItemsFromSession();
        if (listaItems != null) {
            double total = 0;
            for (Item i : listaItems) {
                var producto = productoDao.getReferenceById(i.getIdProducto());
                if (producto.getExistencias() >= i.getCantidad()) {
                    Venta venta = new Venta(factura.getIdFactura(),
                                            i.getIdProducto(),
                                            i.getPrecio(),
                                            i.getCantidad());
                    ventaDao.save(venta);
                    producto.setExistencias(producto.getExistencias() - i.getCantidad());
                    productoDao.save(producto);
                    total += i.getCantidad() * i.getPrecio();
                }
            }

            factura.setTotal(total);
            facturaDao.save(factura);

            listaItems.clear();
        }
    }

    @Override
    public double getTotal() {
        List<Item> listaItems = getItemsFromSession();
        double total = 0;
        if (listaItems != null) {
            for (Item i : listaItems) {
                total += i.getCantidad() * i.getPrecio();
            }
        }
        return total;
    }
}
