const express = require("express")
const app = express()

app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3001');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

app.use(express.json())
const { PrismaClient } =require('@prisma/client')
const prisma = new PrismaClient()

app.get("/",(req,res) => {
    res.send("asd")
})

app.post("/producto", async (req, res) => {
    const { nombre, descripcion, cantidad, precio, id_estante, id_categoria  } = req.body;
    try {
      const prodructoCreado = await prisma.producto.create({
        data: {
          nombre: nombre,
          descripcion: descripcion,
          cantidad: cantidad,
          precio: precio,
          id_estante: id_estante,
          id_categoria : id_categoria
        },
      });
  
      res.json(prodructoCreado);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: "Error al crear el Producto" });
    }
  });

  
  app.put("/producto", async (req, res) => {
    const { id, nombre, descripcion, cantidad, precio } = req.body;
    console.log("id, nombre, descripcion, cantidad, precio")
    console.log(id, nombre, descripcion, cantidad, precio)
  
    try {
      const productoActualizado = await prisma.producto.update({
        where: { id: id },
        data: {
          nombre: nombre,
          descripcion: descripcion,
          cantidad: cantidad,
          precio: precio
        }
      });
  
      // El registro ha sido actualizado correctamente
      res.json(productoActualizado);
    } catch (error) {
      // Ocurrió un error durante la actualización
      console.error(error);
      res.json({ error: 'Error al actualizar el registro' });
    }
  });

  app.get("/producto", async (req, res) => {
      try {
        const productos = await prisma.producto.findMany();
        console.log(productos);
        res.send({productos})
      } catch (error) {
        console.error(error);
      }
  });

  
  app.get("/estantes", async (req, res) => {
    try {
      const estantes = await prisma.estante.findMany();
      console.log(estantes);
      res.send({estantes})
    } catch (error) {
      console.error(error);
    }
});


app.get("/categorias", async (req, res) => {
  try {
    const categorias = await prisma.categoria.findMany();
    console.log(categorias);
    res.send({categorias})
  } catch (error) {
    console.error(error);
  }
});

  app.delete("/producto", async (req, res) => {
    const { id } = req.body;
    try {
      const productoEliminado = await prisma.producto.delete({
        where: {
          id: id,
        },
      });
      console.log(`Producto eliminado: ${productoEliminado}`);
      res.json("Producto Elimi8nado: ", productoEliminado)
    } catch (error) {
      console.error(error);
    }
});

app.listen(3000, () => {
    console.log("corriendo")
})