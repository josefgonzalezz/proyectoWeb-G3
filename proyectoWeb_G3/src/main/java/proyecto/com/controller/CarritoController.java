/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package proyecto.com.controller;

import proyecto.com.domain.Item;
import proyecto.com.domain.Producto;
import proyecto.com.service.ItemService;
import proyecto.com.service.ProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CarritoController {

   @Autowired
   private ItemService itemService;

   @Autowired
   private ProductoService productoService;

   @GetMapping("/carrito/listado")
   public String inicio(Model model) {
       var items = itemService.gets();
       model.addAttribute("items", items);
       int carritoTotalVenta = 0;
       for (Item i : items) {
           carritoTotalVenta += (i.getCantidad() * i.getPrecio());
       }
       model.addAttribute("carritoTotal", carritoTotalVenta);
       return "/carrito/listado";
   }

@GetMapping("/carrito/agregar/{idProducto}/{cantidad}")
public ModelAndView agregarItem(Model model, 
                               @PathVariable Long idProducto, 
                               @PathVariable int cantidad) {
    
    Producto productoParaBuscar = new Producto();
    productoParaBuscar.setIdProducto(idProducto);

    Producto producto = productoService.getProducto(productoParaBuscar);
    
    if (producto == null) {
        return new ModelAndView("redirect:/error");
    }

    // Usamos el método add para manejar suma y validaciones
    itemService.add(new Item(producto), cantidad);

    var lista = itemService.gets();
    int totalCarritos = 0;
    int carritoTotalVenta = 0;
    for (Item i : lista) {
        totalCarritos += i.getCantidad();
        carritoTotalVenta += (i.getCantidad() * i.getPrecio());
    }

    model.addAttribute("listaItems", lista);
    model.addAttribute("listaTotal", totalCarritos);
    model.addAttribute("carritoTotal", carritoTotalVenta);

    return new ModelAndView("/carrito/fragmentos :: verCarrito");
}




@GetMapping("/carrito/modificar/{idProducto}")
public String modificarItem(@PathVariable("idProducto") Long idProducto, Model model) {
    Producto productoParaBuscar = new Producto();
    productoParaBuscar.setIdProducto(idProducto);

    Item item = itemService.get(new Item(productoParaBuscar));
    if (item == null) {
        // Opcional: redirigir o mostrar mensaje si no existe
        return "redirect:/carrito/listado";
    }

    model.addAttribute("item", item);
    return "/carrito/modifica";
}



  @GetMapping("/carrito/eliminar/{idProducto}")
public String eliminarItem(@PathVariable("idProducto") Long idProducto) {
    Producto productoParaBuscar = new Producto();
    productoParaBuscar.setIdProducto(idProducto);
    
    Item item = itemService.get(new Item(productoParaBuscar));
    if (item != null) {
        itemService.delete(item);
    }
    return "redirect:/carrito/listado";
}

@PostMapping("/carrito/guardar")
public String guardarItem(@RequestParam("idProducto") Long idProducto, 
                         @RequestParam("cantidad") int cantidad) {
    Producto producto = new Producto();
    producto.setIdProducto(idProducto);

    Item item = new Item(producto);
    item.setCantidad(cantidad);

    itemService.update(item);
    return "redirect:/carrito/listado";
}


   @GetMapping("/facturar/carrito")
   public String facturarCarrito() {
       itemService.facturar();
       return "redirect:/";
   }
}
